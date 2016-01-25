# Plasm

[![Build Status](https://travis-ci.org/atomic-fads/plasm.svg?branch=master)](https://travis-ci.org/atomic-fads/plasm)

A generic [composable query](http://blog.drewolson.org/composable-queries-ecto/) library for [Ecto](https://github.com/elixir-lang/ecto).

:heart::heart::heart: Ecto, :cry::cry::cry: because I have to implement my own composable query functions for things like counting records, getting a random record and whatnot in all my models/projects.

NO MORE.


## Design Objectives

[X] Work alongside `Ecto.Query` so both can be `import`ed without conflict
[X] Avoid reimplementing `Ecto.Query` functionality where possible
[X] Easy integration with Phoenix
[ ] Support all databases supported by Ecto (right now, use PostgreSQL for all functionality)
[ ] Permissive API (e.g., most functions that accept an atom will alternatively accept a string)


## Examples

Instead of writing this in your model:

``` elixir
def count(query) do
  for q in query,
  select: count(q.id)
end
```

And using it this way:
``` elixir
Quaffle |> Quaffle.count |> Repo.one
```

Just use Plasm:

``` elixir
Quaffle |> Plasm.count |> Repo.one
```

More examples:

``` elixir
Boggart |> Plasm.updated_after("2016-01-04T14:00:00Z") |> Plasm.take(10) |> Repo.all
```

``` elixir
Truffle |> Plasm.for_ids([3,6,9]) |> Repo.all
```

``` elixir
MagicalElixir |> Plasm.random |> Repo.one
```

## Using in Models

You can import Plasm and use it directly in your models:

``` elixir
defmodule MyApp.SomeModel do
  import Plasm

  ...

  def most_recent(query, n) do
    query
    |> order_by_desc(:inserted_at)
    |> take(n)
  end
end
```


## Using with Phoenix

If you want Plasm to be universally accessible in all your Phoenix models, you can add it to `web.ex`:

``` elixir
defmodule MyApp.Web do
  ...

  def model do
    quote do
      ...

      import Plasm
    end
  end
end
```


## API

``` elixir
Plasm.count(query)
Plasm.count_distinct(query, field_name)
Plasm.distinct_by(query, field_name)
Plasm.first(query)
Plasm.first(query, n)
Plasm.for_id(query, id)
Plasm.for_ids(query, ids)
Plasm.for_value(query, field_name, field_value)
Plasm.for_value_not(query, field_name, field_value)
Plasm.for_values(query, field_name, field_values)
Plasm.for_values_not(query, field_name, field_values)
Plasm.inserted_after(query, string_castable_to_ecto_datetime)
Plasm.inserted_after_incl(query, string_castable_to_ecto_datetime)
Plasm.inserted_before(query, string_castable_to_ecto_datetime)
Plasm.inserted_before_incl(query, string_castable_to_ecto_datetime)
Plasm.last(query)
Plasm.last(query, n)
Plasm.random(query)
Plasm.random(query, n)
Plasm.updated_after(query, string_castable_to_ecto_datetime)
Plasm.updated_after_incl(query, string_castable_to_ecto_datetime)
Plasm.updated_before(query, string_castable_to_ecto_datetime)
Plasm.updated_before_incl(query, string_castable_to_ecto_datetime)
```


## Inspiration

Many thanks to Drew Olson (@drewolson) for his [talk at ElixirConf 2015](https://www.youtube.com/watch?v=g84TDHt9MDc) and [insightful blog post](http://blog.drewolson.org/composable-queries-ecto/) on the subject of composable Ecto queries.


## TODO:

- [x] Tests
- [ ] Hex docs


## Installation

Plasm is not yet available via Hex. For now, point to this repo:

    {:plasm, git: "https://github.com/atomic-fads/plasm.git", branch: "master"}

<!-- Add Plasm to your list of dependencies in `mix.exs`:

``` elixir
def deps do
  [{:plasm, "~> 0.0.1"}]
end
```

Ensure Plasm is started before your application:

``` elixir
def application do
  [applications: [:plasm]]
end
```
-->


## Copyright and License

Copyright (c) 2016, Atomic Fads LLC.

Plasm source code is licensed under the Apache 2 License (see LICENSE.md).
