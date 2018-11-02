#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---

_ = """
# lib/music_db/music.ex
defmodule MusicDb.Music do
  alias MusicDb.Music.{Repo, Album, Artist}

  def get_artist(name) do
    MusicDb.Repo.get_by(Artist, name: name)
  end

  def all_albums_by_artist(artist) do
    assoc(artist, :albums)
    |> MusicDb.Repo.all()
  end

  def search_albums(string) do
    Album.search(string)
    |> MusicDb.Repo.all()
  end
end
"""

_ = """
# lib/music_db/music/artist.ex
defmodule MusicDb.Music.Artist do
  use Ecto.Schema

  schema "artists" do
    field :name, :string
    has_many :albums, MusicDb.Music.Album
  end
end

# lib/music_db/music/album.ex
defmodule MusicDb.Music.Album do
  use Ecto.Schema
  alias MusicDb.Music.{Album, Artist}

  schema "albums" do
    field :name, :string
    belongs_to :artist, Artist
  end

  def search(string) do
    from album in Album,
      where: ilike(album.name, ^"%#{string}%"))
   end
end
"""

