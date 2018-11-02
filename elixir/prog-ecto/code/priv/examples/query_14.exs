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

Repo.update_all("artists", set: [updated_at: Ecto.DateTime.utc])

q = from t in "tracks", where: t.title == "Autum Leaves"
Repo.update_all(q, set: [title: "Autumn Leaves"])

from(t in "tracks", where: t.title == "Autum Leaves")
|> Repo.update_all(set: [title: "Autumn Leaves"])

from(t in "tracks", where: t.title == "Autum Leaves")
|> Repo.delete_all

