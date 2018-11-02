#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
alias MusicDB.Repo

Repo.aggregate("albums", :count, :id)
#=> 5

defmodule getting_started_050xample do

  def count(table) do
    aggregate(table, :count, :id)
  end

  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  # to avoid compiler error
  defp aggregate(_, _, _), do: nil
end

"""
Repo.count("albums")
#=> 5
"""



