#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
import Ecto.Query
alias MusicDB.Repo

q = from a in "albums",
  join: ar in "artists", on: a.artist_id == ar.id,
  where: ar.name == "Miles Davis",
  select: [a.title]
Repo.all(q)
#=> [["Cookin' At The Plugged Nickel"], ["Kind Of Blue"]]

q = from a in "albums",
  join: ar in "artists", on: a.artist_id == ar.id,
  join: t in "tracks", on: t.album_id == a.id,
  where: ar.name == "Miles Davis",
  select: [t.title]


