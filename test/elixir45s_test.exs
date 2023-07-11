defmodule Elixir45sTest do
  use ExUnit.Case
  doctest Elixir45s

  test "greets the world" do
    assert Elixir45s.hello() == :world
  end
end
