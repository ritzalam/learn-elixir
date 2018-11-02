#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias MusicDB.{Repo, Artist}

Repo.insert_all("artists", [[name: "John Coltrane"]])
#=> {1, nil}

Repo.insert(%Artist{name: "John Coltrane"})
#=> {:ok, %MusicDB.Artist{__meta__: #Ecto.Schema.Metadata<:loaded, "artists">,
#=>  id: 4, name: "John Coltrane", ...}

Repo.insert_all(Artist, [[name: "John Coltrane"]])
#=> {1, nil}

