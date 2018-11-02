#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias MusicDB.Repo

Repo.insert_all("artists", [%{name: "Max Roach"},
%{name: "Art Blakey"}], returning: [:id, :name])
#=> {2, [%{id: 12, name: "Max Roach"}, %{id: 13, name: "Art Blakey"}]}

Ecto.Adapters.SQL.query(Repo, "select * from artists where id=1")
#=> {:ok,
#=>  %Postgrex.Result{
#=>    columns: ["id", "name", "birth_date", "death_date", "inserted_at",
#=>     "updated_at"],
#=>    command: :select,
#=>    connection_id: 11752,
#=>    num_rows: 1,
#=>    rows: [
#=>      [
#=>        1,
#=>        "Miles Davis",
#=>        nil,
#=>        nil,
#=>        {{2018, 4, 27}, {13, 54, 43, 607013}},
#=>        {{2018, 4, 27}, {13, 54, 43, 607020}}
#=>      ]
#=>    ]
#=>  }}

Repo.query("select * from artists where id=1")
