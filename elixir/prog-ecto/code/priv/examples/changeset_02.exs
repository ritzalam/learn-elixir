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
alias MusicDB.{Repo, Artist}

import Ecto.Changeset

changeset = change(%Artist{name: "Charlie Parker"})

artist = Repo.one(from a in Artist, where: a.name == "Bobby Hutcherson")
changeset = change(artist)

artist = Repo.one(from a in Artist, where: a.name == "Bobby Hutcherson")
changeset = change(artist, name: "Robert Hutcherson")

changeset.changes
#=> %{name: "Robert Hutcherson"}

changeset = change(changeset, birth_date: ~D[1941-01-27])

artist = Repo.one(from a in Artist, where: a.name == "Bobby Hutcherson")
changeset = change(artist, name: "Robert Hutcherson",
  birth_date: ~D[1941-01-27])

changeset.changes
#=> %{birth_date: ~D[1941-01-27], name: "Robert Hutcherson"}


