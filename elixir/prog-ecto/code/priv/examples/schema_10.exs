#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
import Ecto.Query
alias MusicDB.{Repo, Album, Artist}

album = Repo.one(
  from a in Album,
  where: a.title == "Kind Of Blue"
)

album.tracks

#Ecto.Association.NotLoaded<association :tracks is not loaded>

albums = Repo.all(from a in Album, preload: :tracks)

albums =
  Album
  |> Repo.all
  |> Repo.preload(:tracks)

Repo.all(from a in Artist, preload: [albums: :tracks])

q = from a in Album,
  join: t in assoc(a, :tracks),
  where: t.title == "Freddie Freeloader",
  preload: [tracks: t]

