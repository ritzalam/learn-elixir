#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias MusicDB.Repo

Repo.insert_all("genres", [[name: "ska", wiki_tag: "Ska_music"]])
# => {1, nil}

try do
Repo.insert_all("genres", [[name: "ska", wiki_tag: "Ska_music"]])
# => ** (Postgrex.Error) ERROR 23505 (unique_violation): duplicate key
# => value violates unique constraint "genres_name_index"
rescue
  e in Postgrex.Error -> IO.inspect(e)
end

Repo.insert_all("genres", [[name: "ska", wiki_tag: "Ska_music"]],
  on_conflict: :nothing)
# => {0, nil}

try do
Repo.insert_all("genres", [[name: "ska", wiki_tag: "Ska"]],
  on_conflict: :replace_all, returning: [:wiki_tag])
 # => ** (Postgrex.Error) ERROR 42601 (syntax_error): ON CONFLICT
 #=>  DO UPDATE requires inference specification or constraint name
rescue
  e in Postgrex.Error -> IO.inspect(e)
end

Repo.insert_all("genres", [[name: "ska", wiki_tag: "Ska"]],
  on_conflict: :replace_all, conflict_target: :name, returning: [:wiki_tag])
# => {1, [%{wiki_tag: "Ska"}]}

Repo.insert_all("genres", [[name: "ambient", wiki_tag: "Ambient_music"]],
  on_conflict: :replace_all, conflict_target: :name, returning: [:wiki_tag])
# => {1, [%{wiki_tag: "Ambient_music"}]}

Repo.insert_all("genres", [[name: "ambient", wiki_tag: "Ambient_music"]],
  on_conflict: [set: [wiki_tag: "Ambient_music"]],
  conflict_target: :name, returning: [:wiki_tag])
