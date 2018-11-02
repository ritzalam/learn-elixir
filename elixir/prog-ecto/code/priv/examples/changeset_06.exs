#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
import Ecto.Changeset
alias MusicDB.{Repo, Genre}

Repo.insert(%Genre{name: "speed polka"})

Repo.insert!(%Genre{ name: "bebop" })

params = %{"name" => "bebop"}
changeset =
  %Genre{}
  |> cast(params, [:name])
  |> validate_required(:name)
  |> validate_length(:name, min: 3)
  |> unique_constraint(:name)
changeset.errors
#=> []

params = %{"name" => "bebop"}
changeset =
  %Genre{}
  |> cast(params, [:name])
  |> validate_required(:name)
  |> validate_length(:name, min: 3)
  |> unique_constraint(:name)
case Repo.insert(changeset) do
  {:ok, _genre} -> IO.puts "Success!"
  {:error, changeset} -> IO.inspect changeset.errors
end
#=> [name: {"has already been taken", []}]


