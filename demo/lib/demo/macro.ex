defmodule Demo.Macro do

  defmacro hello(ast) do
    IO.inspect(ast)
  end

  defmacro begin(do: do_block, rescue: rescue_block) do
    quote do
      try do
        unquote(do_block)
      rescue
        _ -> unquote(rescue_block)
      end
    end
  end

  defmacro repeat(num, do: block) do
    List.duplicate(block, num)
  end
end
