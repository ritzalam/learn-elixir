#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias MusicDB.{Repo, Genre}

genre = %Genre{name: "funk", wiki_tag: "Funk"}
Repo.insert(genre)
#=> {:ok,
#=> %MusicDB.Genre{__meta__: #Ecto.Schema.Metadata<:loaded, "genres">,
#=>  albums: #Ecto.Association.NotLoaded<association :albums is not loaded>,
#=>  id: 3, inserted_at: ~N[2018-03-05 14:26:13.384276], name: "funk",
#=>  updated_at: ~N[2018-03-05 14:26:13.384285], wiki_tag: "Funk"}}

Repo.insert(genre, on_conflict: [set: [wiki_tag: "Funk_music"]],
  conflict_target: "name")
#=> {:ok,
#=> %MusicDB.Genre{__meta__: #Ecto.Schema.Metadata<:loaded, "genres">,
#=>  albums: #Ecto.Association.NotLoaded<association :albums is not loaded>,
#=>  id: 3,inserted_at: ~N[2018-03-05 14:27:14.850467], name: "funk",
#=>  updated_at: ~N[2018-03-05 14:27:14.850480], wiki_tag: "Funk"}}

Repo.get(Genre, 3)
#=> %MusicDB.Genre{__meta__: #Ecto.Schema.Metadata<:loaded, "genres">,
#=>  albums: #Ecto.Association.NotLoaded<association :albums is not loaded>,
#=>  id: 3,inserted_at: ~N[2018-03-05 14:26:13.384276], name: "funk",
#=>  updated_at: ~N[2018-03-05 14:26:13.384285], wiki_tag: "Funk_music"}

