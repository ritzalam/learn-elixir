#---
# Excerpted from "Programming Ecto",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wmecto for more book information.
#---
def deps() do
  [{:music, in_umbrella: true}]
end

_ = """
defmodule Forum.Post do
  schema "posts" do
    belongs_to :user, Accounts.User
  end
end

defmodule Accounts.User do
  schema "user" do
    # This is not allowed due to the one-directional relationship
    # has_many :posts, Forum.Post
  end
end
"""

_ = """
defmodule Forum.Post do
  def from_user(user_or_users) do
    # assoc() can take a single schema or a list - we'll do the same
    user_ids = user_or_users |> List.wrap() |> Enum.map(& &1.id)
    from p in Post,
      where: p.user_id in ^user_ids
  end
end
"""


