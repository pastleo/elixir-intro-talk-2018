defmodule Demo.Flow do
  alias Demo.Process
  import Demo.Macro

  def without_flow(x \\ 40) do
    repeat 10 do
      Process.fibonacci(x) |> IO.puts()
    end
  end

  def run(x \\ 40) do
    Flow.from_enumerable(1..10)
    |> Flow.partition()
    |> Flow.each(fn(_) -> Process.fibonacci(x) |> IO.puts() end)
    |> Flow.run()
  end

end
