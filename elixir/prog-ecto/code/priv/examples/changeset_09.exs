#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
import Ecto.Query
alias MusicDB.{Repo, Artist}

artist = Repo.one(from a in Artist, where: a.name == "Miles Davis")
new_album = Ecto.build_assoc(artist, :albums)
#=> %MusicDB.Album{artist_id: 1, ...}

artist = Repo.one(from a in Artist, where: a.name == "Miles Davis")
album = Ecto.build_assoc(artist, :albums, title: "Miles Ahead")
#=> %MusicDB.Album{artist_id: 1, title: "Miles Ahead", ...}

artist = Repo.one(from a in Artist, where: a.name == "Miles Davis")
album = Ecto.build_assoc(artist, :albums, title: "Miles Ahead")
Repo.insert(album)
#=> {:ok, %MusicDB.Album{id: 6, title: "Miles Ahead", artist_id: 1, ...}

artist = Repo.one(from a in Artist, where: a.name == "Miles Davis",
  preload: :albums)
Enum.map(artist.albums, &(&1.title))
#=> ["Miles Ahead", "Cookin' At The Plugged Nickel", "Kind Of Blue"]



