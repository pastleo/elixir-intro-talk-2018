defmodule Demo.Fibonacci do
  use GenServer

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
    :ok
  end

  def call(x) do
    GenServer.call(__MODULE__, x)
  end

  def fibonacci(x, cache \\ %{})
  def fibonacci(0, cache), do: {0, cache}
  def fibonacci(1, cache), do: {1, cache}
  def fibonacci(x, cache) do
    case cache do
      %{^x => result} -> {result, cache}
      _ ->
        {result_1, cache_1} = fibonacci(x - 2, cache)
        {result_2, cache_2} = fibonacci(x - 1, cache_1)
        result = result_1 + result_2
        {result, Map.put(cache_2, x, result)}
    end
  end

  # ===
  
  def init(_) do
    {:ok, %{}}
  end

  def handle_call(x, _from, cache) do
    {result, new_cache} = fibonacci(x, cache)
    {:reply, result, new_cache}
  end

end
