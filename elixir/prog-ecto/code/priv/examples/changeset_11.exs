#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
import Ecto.Changeset
import Ecto.Query
alias MusicDB.{Repo, Artist, Album}

params = %{"name" => "Esperanza Spalding",
  "albums" => [%{"title" => "Junjo"}]}
changeset =
  %Artist{}
  |> cast(params, [:name])
  |> cast_assoc(:albums)
changeset.changes

defmodule FakeAlbumModule do
  # add this to lib/music_db/album.ex
  def changeset(album, params) do
    album
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end

params = %{"name" => "Esperanza Spalding",
  "albums" => [%{"title" => "Junjo"}]}
changeset =
  %Artist{}
  |> cast(params, [:name])
  |> cast_assoc(:albums)
changeset.changes
#=> %{albums: [#Ecto.Changeset<action: :insert,
#=>  changes: %{title: "Junjo"}, errors: [],
#=>  data: #MusicDB.Album<>, valid?: true>],
#=>  name: "Esperanza Spalding"}

artist = Repo.one(from a in Artist, where: a.name == "Bill Evans",
  preload: :albums)
IO.inspect Enum.map(artist.albums, &({&1.id, &1.title}))
#=> [{4, "Portrait In Jazz"}, {3, "You Must Believe In Spring"}]

portrait = Repo.one(from a in Album, where: a.title == "Portrait In Jazz")
kind_of_blue = Repo.one(from a in Album, where: a.title == "Kind Of Blue")
params = %{"albums" =>
  [
    %{"title" => "Explorations"},
    %{"title" => "Portrait In Jazz (remastered)", "id" => portrait.id},
    %{"title" => "Kind Of Blue", "id" => kind_of_blue.id}
  ]
}

# For this next example to work, this needs to be changed in music_db/artist.ex:
#
#  has_many :albums, MusicDB.Album, on_replace: :nilify
#

portrait = Repo.one(from a in Album,
  where: a.title == "Portrait In Jazz")
kind_of_blue = Repo.one(from a in Album,
  where: a.title == "Kind Of Blue")
params = %{"albums" =>
  [
    %{"title" => "Explorations"},
    %{"title" => "Portrait In Jazz (remastered)", "id" => portrait.id},
    %{"title" => "Kind Of Blue", "id" => kind_of_blue.id}
  ]
}

artist = Repo.one(from a in Artist,
  where: a.name == "Bill Evans", preload: :albums)
{:ok, artist} =
  artist
  |> cast(params, [])
  |> cast_assoc(:albums)
  |> Repo.update
Enum.map(artist.albums, &({&1.id, &1.title}))
#=> [{6, "Explorations"}, {4, "Portrait In Jazz (remastered)"},
#=>  {7, "Kind Of Blue"}]

Repo.all(from a in Album, where: a.title == "Kind Of Blue")
|> Enum.map(&({&1.id, &1.title}))
#=> [{1, "Kind Of Blue"}, {7, "Kind Of Blue"}]

Repo.all(from a in Album, where: a.title == "You Must Believe In Spring")
|> Enum.map(&({&1.id, &1.title, &1.artist_id}))
#=> [{3, "You Must Believe In Spring", nil}]

