#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
import Ecto.Query
alias MusicDB.{Repo, Track}

Repo.delete_all("tracks")

from(t in "tracks", where: t.title == "Autum Leaves")
|> Repo.delete_all

Repo.insert!(%Track{title: "The Moontrane", index: 1})

track = Repo.get_by(Track, title: "The Moontrane")
Repo.delete(track)
#=> {:ok, %MusicDB.Track{__meta__: #Ecto.Schema.Metadata<:deleted, "tracks">,
#=>  id: 28, title: "The Moontrane", ...}


