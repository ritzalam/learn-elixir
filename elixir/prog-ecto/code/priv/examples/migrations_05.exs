#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---

defmodule MusicDB.Repo.Migrations.NoPrimaryKey do
  use Ecto.Migration

  def change do
    create table("compositions", primary_key: false) do
      #...
    end
  end
end

defmodule MusicDB.Repo.Migrations.ExplicitPrimaryKey do
  use Ecto.Migration

  def change do
    create table("compositions", primary_key: false) do
      add :code, :string, primary_key: true
      #...
    end
  end
end

defmodule MusicDB.Repo.Migrations.ForeignKey do
  use Ecto.Migration

  def change do
    create table("compositions_artists") do
      add :composition_id, references("compositions",
        column: "code", type: "string")
      #...
    end
  end
end

defmodule MusicDB.Repo.Migrations.TimestampNames do
  use Ecto.Migration

  def change do
    create table("compositions") do
      timestamps(inserted_at: :created_at, updated_at: :changed_at,
        type: :utc_datetime)
      #...
    end
  end
end

defmodule MusicDB.Repo.Migrations.SkipTimestamp do
  use Ecto.Migration

  def change do
    create table("compositions") do
      timestamps updated_at: false
      #...
    end
  end
end

defmodule MusicDB.Repo.Migrations.AddCompositionsIndex do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    #...
  end
end

defmodule MusicDB.Repo.Migrations.AddCompositionsIndex do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create index("compositions", :title, concurrently: true)
  end
end

