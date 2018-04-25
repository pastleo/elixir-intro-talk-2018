defmodule Demo do
  @moduledoc """
  a demo of talk on ruby x elixir conf tw 2018 by pastleo
  """

  def sum_ints(str) do
    String.split(str, ",")
    |> Enum.map(fn(x) -> Integer.parse(x) end)
    |> Enum.flat_map(&valid_int/1)
    |> Enum.sum()
  end

  defp valid_int({int, _}), do: [int]
  defp valid_int(_), do: []
end
