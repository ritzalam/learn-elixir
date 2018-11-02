#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias Ecto.Multi
alias MusicDB.{Repo, Artist}

Repo.insert!(%Artist{name: "Johnny Hodges"})

artist = Repo.get_by(Artist, name: "Johnny Hodges")
artist_changeset = Artist.changeset(artist,
  %{name: "John Cornelius Hodges"})
invalid_changeset = Artist.changeset(%Artist{},
  %{name: nil})
multi =
  Multi.new
  |> Multi.update(:artist, artist_changeset)
  |> Multi.insert(:invalid, invalid_changeset)
Repo.transaction(multi)
#=> {:error, :invalid,
#=>  #Ecto.Changeset<
#=>    action: :insert,
#=>    changes: %{},
#=>    errors: [name: {"can't be blank", [validation: :required]}],
#=>    data: #MusicDB.Artist<>,
#=>    valid?: false
#=>  >, %{}}

case Repo.transaction(multi) do
  {:ok, _results} ->
    IO.puts "Operations were successful."
  {:error, :artist, changeset, _changes} ->
    IO.puts "Artist update failed"
    IO.inspect changeset.errors
  {:error, :invalid, changeset, _changes} ->
    IO.puts "Invalid operation failed"
    IO.inspect changeset.errors
end

artist = Repo.get_by(Artist, name: "Johnny Hodges")
artist_changeset = Artist.changeset(artist,
  %{name: "John Cornelius Hodges"})
invalid_changeset = Artist.changeset(%Artist{},
  %{name: nil})
multi =
  Multi.new
  |> Multi.update(:artist, artist_changeset)
  |> Multi.insert(:invalid, invalid_changeset)
Repo.transaction(multi)
#=> {:error, :invalid,
#=>  #Ecto.Changeset<
#=>    action: :insert,
#=>    changes: %{},
#=>    errors: [name: {"can't be blank", [validation: :required]}],
#=>    data: #MusicDB.Artist<>,
#=>    valid?: false
#=>  >, %{}}

artist = Repo.get_by(Artist, name: "Johnny Hodges")
artist_changeset = Artist.changeset(artist,
  %{name: "John Cornelius Hodges"})
multi =
  Multi.new
  |> Multi.update(:artist, artist_changeset)
  |> Multi.error(:invalid, "oops!")
Repo.transaction(multi)
#=> {:error, :invalid, "oops!",
#=> %{
#=>   artist: %MusicDB.Artist{
#=>     __meta__: #Ecto.Schema.Metadata<:loaded, "artists">,
#=>     albums: #Ecto.Association.NotLoaded<association
#=>       :albums is not loaded>,
#=>     birth_date: nil,
#=>     death_date: nil,
#=>     id: 4,
#=>     inserted_at: ~N[2018-03-23 14:02:28.689538],
#=>     name: "John Cornelius Hodges",
#=>     tracks: #Ecto.Association.NotLoaded<association
#=>       :tracks is not loaded>,
#=>     updated_at: ~N[2018-03-23 14:02:28.708510]
#=>   }
#=> }}

Repo.get_by(Artist, name: "John Cornelius Hodges")
#=> nil

multi =
  Multi.new
  |> Multi.insert(:artist, %Artist{})

# Running this line will cause a Postgrex error
_ = """
Repo.transaction(multi)
#=> ** (Postgrex.Error) ERROR 23502 (not_null_violation): null value
#=>  in column "name" violates not-null constraint
"""
