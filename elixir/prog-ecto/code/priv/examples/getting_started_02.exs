#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias MusicDB.Repo

Repo.insert_all("artists", [[name: "John Coltrane"]])
#=> {1, nil}

Repo.insert_all("artists",
  [[name: "Sonny Rollins", inserted_at: Ecto.DateTime.utc]])
#=> {1, nil}

Repo.insert_all("artists",
  [[name: "Max Roach", inserted_at: Ecto.DateTime.utc],
  [name: "Art Blakey", inserted_at: Ecto.DateTime.utc]])
#=> {2, nil}

Repo.insert_all("artists",
  [%{name: "Max Roach", inserted_at: Ecto.DateTime.utc},
   %{name: "Art Blakey", inserted_at: Ecto.DateTime.utc}])
#=> {2, nil}

Repo.update_all("artists", set: [updated_at: Ecto.DateTime.utc])
#=> {9, nil}

Repo.delete_all("tracks")
#=> {30, nil}

