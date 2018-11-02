#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
defmodule MusicDB.Artist do
  use Ecto.Schema
  import Ecto.Changeset
  alias MusicDB.Album

  schema "artists" do
    field(:name)
    field(:birth_date, :date)
    field(:death_date, :date)
    timestamps()

    has_many(:albums, Album, on_replace: :nilify)
    has_many(:tracks, through: [:albums, :tracks])
  end

  def changeset(artist, params) do
    artist
    |> cast(params, [:name, :birth_date, :death_date])
    |> validate_required([:name])
  end
end
