defmodule RedisExampleTest do
  use ExUnit.Case
  doctest RedisExample

  test "greets the world" do
    assert RedisExample.hello() == :world
  end
end
