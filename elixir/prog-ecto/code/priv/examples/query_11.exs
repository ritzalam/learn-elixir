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

albums_by_miles = from a in "albums",
  join: ar in "artists", on: a.artist_id == ar.id,
  where: ar.name == "Miles Davis"

album_query = from a in albums_by_miles, select: a.title
#=> #Ecto.Query<from a0 in "albums", join: a1 in "artists",
#=>  on: a0.artist_id == a1.id, where: a1.name == "Miles Davis",
#=>  select: a0.title>

album_query = from a in albums_by_miles, select: a.title
Repo.all(album_query)
#=> ["Cookin' At The Plugged Nickel", "Kind Of Blue"]

albums_by_miles = from a in "albums",
  join: ar in "artists", on: a.artist_id == ar.id,
  where: ar.name == "Miles Davis"

album_query = from [a,ar] in albums_by_miles, select: a.title

album_query = from [ar,a] in albums_by_miles, select: a.title

album_query = from albums in albums_by_miles, select: albums.title

track_query = from a in albums_by_miles,
  join: t in "tracks", on: a.id == t.album_id,
  select: t.title

albums_by_miles = from a in "albums",
  join: ar in "artists", on: a.artist_id == ar.id,
  where: ar.name == "Miles Davis"

album_query = from a in albums_by_miles, select: a.title
miles_albums = Repo.all(album_query)

track_query = from a in albums_by_miles,
  join: t in "tracks", on: a.id == t.album_id,
  select: t.title
miles_tracks = Repo.all(track_query)

