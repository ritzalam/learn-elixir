#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
has_many :notes, MusicDB.Note

album = Repo.get_by(Album, title: "Kind Of Blue")
note = Ecto.build_assoc(album, :notes,
  note: "Love this album!", author: "darin")
Repo.insert!(note)
album = Repo.preload(album, :notes)
album.notes
# => [
#  %MusicDB.Note{
#    __meta__: #Ecto.Schema.Metadata<:loaded, "notes_with_fk_fields">,
#    album: #Ecto.Association.NotLoaded<association :album is not loaded>,
#    album_id: 1,
#    artist: #Ecto.Association.NotLoaded<association :artist is not loaded>,
#    artist_id: nil,
#    author: "darin",
#    id: 1,
#    inserted_at: ~N[2018-08-15 18:01:12.907231],
#    note: "Love this album!",
#    track: #Ecto.Association.NotLoaded<association :track is not loaded>,
#    track_id: nil,
#    updated_at: ~N[2018-08-15 18:01:12.907250]
#  }
#]

artist = Repo.get_by(Artist, name: "Bobby Hutcherson")
note = Ecto.build_assoc(artist, :notes,
  note: "My fave vibes player", author: "darin")
Repo.insert!(note)
artist = Repo.preload(artist, :notes)
artist.notes
# => [
#  %MusicDB.Note{
#    ...
#  }
#]

album = Repo.get_by(Album, title: "Kind Of Blue")
note = Repo.insert!(%Note{note: "Love this album!", author: "darin"})
album
|> Repo.preload(:notes)
|> Ecto.Changeset.change()
|> Ecto.Changeset.put_assoc(:notes, [note])
|> Repo.update!
album = Repo.preload(album, :notes)
album.notes

