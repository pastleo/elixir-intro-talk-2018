## Not familiar with Elixir? Let me do a simple intro in 30 minutes

借用您半小時，請問有聽過 elixir 嗎？

by [PastLeo](https://pastleo.me), a little developer at [5xruby](https://5xruby.tw)

---

## Outline

* Functional Syntax
* Macro
* Process, message passing
* Application
    * A database migration tool
* Resources

---

## Functional Syntax

---

#### let's say I want a function...

```elixir
Demo.sum_ints("1,3,asdf,5")
# => 9
```

---

## let me demo how to create this function

```elixir
test "sum_ints" do
  assert Demo.sum_ints(
    "1,3,asdf,5"
  ) == 9
end
```

---

### pipe, pattern matching


```elixir
defmodule Demo do
  def sum_ints(str) do
    String.split(str, ",")
    |> Enum.map(&Integer.parse/1)
    |> Enum.flat_map(&valid_int/1)
    |> Enum.sum()
  end

  defp valid_int({int, _}), do: [int]
  defp valid_int(_), do: []
end
```

---

## Macro

---

#### a glimpse of ecto

a bridge between database in elixir

```elixir
query = from u in "users",
          where: u.age > 18,
          select: u.name
```

[Ecto.Query document](https://hexdocs.pm/ecto/Ecto.Query.html#content)

---

#### how macro works


```elixir
quote do 1 + 1 end
```

```elixir
defmodule Demo.Macro do
  defmacro hello(ast) do
    IO.inspect(ast)
  end
end
```

---

#### let's bring `begin` from ruby

```elixir
begin do
  1/0
rescue
  :error
end

# => :error
```

---

#### `quote` and `unquote`

```elixir
defmacro begin(
  do: do_block, rescue: rescue_block
) do
  quote do
    try do
      unquote(do_block)
    rescue
      _ -> unquote(rescue_block)
    end
  end
end
```

---

#### actually...

* [defmacro if](https://github.com/elixir-lang/elixir/blob/v1.6.4/lib/elixir/lib/kernel.ex#L2840)
* [defmacro defmodule](https://github.com/elixir-lang/elixir/blob/v1.6.4/lib/elixir/lib/kernel.ex#L3589)
* [defmacro def](https://github.com/elixir-lang/elixir/blob/v1.6.4/lib/elixir/lib/kernel.ex#L3834)
* [defmacro defmacro](https://github.com/elixir-lang/elixir/blob/v1.6.4/lib/elixir/lib/kernel.ex#L3886)

---

## Process, message passing

---

#### why concurrent/parallel is so hard

![race condition](https://i.imgur.com/RWgYIC3.gif)

[reddit 'Perfect demonstration of a race condition.'](https://www.reddit.com/r/ProgrammerHumor/comments/2skae8/perfect_demonstration_of_a_race_condition/)

---

#### start a process

```elixir
spawn(fn -> ... end)
```

not system process nor thread

---

#### start a lot of processes

```elixir
Enum.each(1..10000, fn(_) ->
  spawn(fn ->
    IO.inspect(self())
  end)
end)
```

---

#### Message passing

```elixir
me = self()
spawn(fn ->
  send(me, self())
end)

receive do
  x -> IO.inspect(x)
end
```

---

#### Fibonacci Service

```elixir
defmodule Demo.Process do
  def fibonacci_service do
    receive do
      x -> fibonacci(x) |> IO.puts()
    end
    fibonacci_service()
  end
end
```

---

#### One step forward: OTP

* shorthand of [Open Telecom Platform](https://en.wikipedia.org/wiki/Open_Telecom_Platform)
* process communication
    * [GenServer](https://hexdocs.pm/elixir/GenServer.html)
* process maintaining
    * [Supervisor](https://hexdocs.pm/elixir/Supervisor.html)
* code replacement

---

#### Tip of the iceberg of phoenix server processes

![observer](https://i.imgur.com/X1oYJBF.png?1)

---

## Application

#### the migration tool

---

#### Purpose

![altr purpose](https://i.imgur.com/uzbPx39.png)

---

#### How to match

```elixir
[1, 2, 3] -- [1, 3]
# => [2]
```

```elixir
[source html nodes] --
  [all possible html nodes for a template]
    == []
```

```elixir
[required html nodes for a template] --
  [source html nodes]
    == []
```

---

#### using [GenStage](https://hexdocs.pm/gen_stage/GenStage.html) and [Flow](https://hexdocs.pm/flow/Flow.html) to do full migrate

* postgres streaming producer
    * data source is only one big query
* use `Flow` to utilize all CPUs
* result speed:
    * around 86000+ users, each of them has 5 pages in average
    * 430000+ pages in 20 minutes

---

#### listening to postgres trigger

* user changed
    * `|>` postgres trigger
    * `|>` postgres channel
    * `|>` elixir process event loop
    * `|>` re-migrate on the specific user
* [postgrex notification module](https://github.com/elixir-ecto/postgrex/blob/master/lib/postgrex/notifications.ex)

---

#### more processes

* states:
    * currently being migrated user
    * excluded user
    * queued user
    * success rate, statistic
* progress bar

---

#### how it looks like when running

![altr running](https://static.pastleo.me/2018-elixir-intro/altr-running.gif)

---

## Learning Resource

* [Elixirschool](https://elixirschool.com/en/)
* [Elixir official guide](https://elixir-lang.org/getting-started/introduction.html)
* [Elixir for Programmers (Video, Dave Thomas)](https://codestool.coding-gnome.com/courses/elixir-for-programmers)
* [Elixir official learning resources](https://elixir-lang.org/learning.html)

---

## Thanks for listening!


#### Any questions?

