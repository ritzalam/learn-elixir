#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
defmodule MusicDB.Repo.Migrations.AddCompositionArtistsTable do
  use Ecto.Migration

  def change do
    create table("compositions_artists") do
      add :composition_id, references("compositions"), null: false
      add :artist_id, references("artists"), null: false
      add :role, :string, null: false
    end

    create index("compositions_artists", :composition_id)
    create index("compositions_artists", :artist_id)
  end
end

defmodule MusicDB.Repo.Migrations.AddCompositionArtistsTable2 do
  use Ecto.Migration
  import Ecto.Query

  def change do
    #...

    from(c in "compositions", select: [:id, :artist_id])
    |> Repo.all()
    |> Enum.each(fn row ->
      Repo.insert_all("compositions_artists", [
        [composition_id: row.id, artist_id: row.artist_id, role: "composer"]
      ])
    end)
  end
end

defmodule MusicDB.Repo.Migrations.AddCompositionArtistsTable3 do
  use Ecto.Migration
  def change do
    #...

    alter table("compositions") do
      remove :artist_id
    end
  end
end

defmodule MusicDB.Repo.Migrations.AddCompositionArtistsTable4 do
  use Ecto.Migration
  import Ecto.Query

  def change do
    #...

    create(index("compositions_artists", :composition_id))
    create(index("compositions_artists", :artist_id))

    flush()

    from(c in "compositions", select: [:id, :artist_id])
    |> Repo.all()

    #...

  end
end

defmodule MusicDB.Repo.Migrations.AddCompositionArtistsTable do
  use Ecto.Migration
  import Ecto.Query
  alias MusicDB.Repo

  def change do
    create table("compositions_artists") do
      add(:composition_id, references("compositions"), null: false)
      add(:artist_id, references("artists"), null: false)
      add(:role, :string, null: false)
    end

    create(index("compositions_artists", :composition_id))
    create(index("compositions_artists", :artist_id))

    flush()

    from(c in "compositions", select: [:id, :artist_id])
    |> Repo.all()
    |> Enum.each(fn row ->
      Repo.insert_all("compositions_artists", [
        [composition_id: row.id, artist_id: row.artist_id, role: "composer"]
      ])
    end)

    alter table("compositions") do
      remove :artist_id
    end
  end
end

