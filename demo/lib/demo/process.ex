defmodule Demo.Process do

  def start_a_process do
    IO.inspect(self())
    spawn(fn ->
      IO.inspect(self())
    end)
  end

  def start_a_lot_of_processes(num \\ 10000) do
    Enum.each(1..num, fn(_) ->
      spawn(fn ->
        IO.inspect(self())
      end)
    end)
  end

  def message_passing do
    me = self()
    spawn(fn ->
      send(me, self())
    end)

    receive do
      x -> IO.inspect(x)
    end
  end

  def start_fibonacci_service do
    spawn(__MODULE__, :fibonacci_service, [])
  end

  def fibonacci_service do
    receive do
      x -> fibonacci(x) |> IO.puts()
    end
    fibonacci_service()
  end

  def fibonacci(0), do: 0
  def fibonacci(1), do: 1
  def fibonacci(x) do
    fibonacci(x - 1) + fibonacci(x - 2)
  end
end
