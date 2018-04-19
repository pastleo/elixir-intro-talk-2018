defmodule DemoTest do
  use ExUnit.Case
  doctest Demo

  test "sum_ints" do
    assert Demo.sum_ints(
      "1,3,asdf,5"
    ) == 9
  end
end
