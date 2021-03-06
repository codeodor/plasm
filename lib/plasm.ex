defmodule Plasm do
  import Ecto.Query

  @doc """
  Builds an avg query for a given field.

      Puppy |> Plasm.avg(:age) |> Repo.one
  """
  def avg(query, field_name) do
    query
    |> select([x], avg(field(x, ^field_name)))
  end

  @doc """
  Builds a count query.

      Puppy |> Plasm.count |> Repo.one
  """
  def count(query) do
    query
    |> select([x], count(x.id))
  end

  @doc """
  Builds a distinct count query for a given field (string).

      Puppy |> Plasm.count_distinct("age") |> Repo.one
  """
  def count_distinct(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> count_distinct(field_name)
  end

  @doc """
  Builds a distinct count query for a given field (atom).

      Puppy |> Plasm.count_distinct(:name) |> Repo.one
  """
  def count_distinct(query, field_name) when is_atom(field_name) do
    query
    |> select([x], count(field(x, ^field_name), :distinct))
  end

  @doc """
  Builds a distinct query for a given field (string).

      Puppy |> Plasm.distinct_by("name") |> Repo.all
  """
  def distinct_by(query, field_name) when is_binary(field_name) do
    field_name = String.to_atom(field_name)

    query
    |> distinct_by(field_name)
  end

  @doc """
  Builds a distinct query for a given field (atom).

      Puppy |> Plasm.distinct_by(:name) |> Repo.all
  """
  def distinct_by(query, field_name) when is_atom(field_name) do
    query
    |> distinct([x], field(x, ^field_name))
  end

  @doc """
  Builds a query that finds all records matching any of the primary key values in the provided list.

      Puppy |> Plasm.find([1,2,3]) |> Repo.all
  """
  def find(query, primary_key_values) when is_list(primary_key_values) do
    key = primary_key(query)

    query
    |> where_all([{key, primary_key_values}])
  end

  @doc """
  Builds a query that finds the record matching the provided primary key value.

      Puppy |> Plasm.find(10) |> Repo.one
  """
  def find(query, primary_key_value) do
    key = primary_key(query)

    query
    |> where_all([{key, primary_key_value}])
  end

  @doc """
  Builds a query that finds the first record after sorting by `inserted_at` ascending.

      Puppy |> Plasm.first |> Repo.one
  """
  def first(query) do
    query
    |> first(1)
  end

  @doc """
  Builds a query that finds the first n records after sorting by `inserted_at` ascending.

      Puppy |> Plasm.first(20) |> Repo.all
  """
  def first(query, n) do
    query
    |> order_by(asc: :inserted_at)
    |> limit(^n)
  end

  @doc """
  Builds a query that finds all records inserted after a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_after(ecto_date_time) |> Repo.all
  """
  def inserted_after(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at > ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted after a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_after("2014-04-17T14:00:00Z") |> Repo.all
  """
  def inserted_after(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_after(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted on or after a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_after_incl(ecto_date_time) |> Repo.all
  """
  def inserted_after_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at >= ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted on or after a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_after_incl("2014-04-17T14:00:00Z") |> Repo.all
  """
  def inserted_after_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_after_incl(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted before a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_before(ecto_date_time) |> Repo.all
  """
  def inserted_before(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at < ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted before a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_before("2014-04-17T14:00:00Z") |> Repo.all
  """
  def inserted_before(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_before(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted on or before a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_before_incl(ecto_date_time) |> Repo.all
  """
  def inserted_before_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.inserted_at <= ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records inserted on or before a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.inserted_before_incl("2014-04-17T14:00:00Z") |> Repo.all
  """
  def inserted_before_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> inserted_before_incl(ecto_date_time)
  end

  @doc """
  Builds a query that finds the last record after sorting by `inserted_at` ascending.

      Puppy |> Plasm.last |> Repo.one
  """
  def last(query) do
    query
    |> last(1)
  end

  @doc """
  Builds a query that finds the last n records after sorting by `inserted_at` ascending.

      Puppy |> Plasm.last(20) |> Repo.all
  """
  def last(query, n) do
    query
    |> order_by(desc: :inserted_at)
    |> limit(^n)
  end

  @doc """
  Builds a max query for a given field.

      Puppy |> Plasm.max(:age) |> Repo.one
  """
  def max(query, field_name) do
    query
    |> select([x], max(field(x, ^field_name)))
  end

  @doc """
  Builds a min query for a given field.

      Puppy |> Plasm.min(:age) |> Repo.one
  """
  def min(query, field_name) do
    query
    |> select([x], min(field(x, ^field_name)))
  end

  @doc """
  Builds a query that grabs a random record.

      Puppy |> Plasm.random |> Repo.one
  """
  def random(query) do
    query
    |> random(1)
  end

  @doc """
  Builds a query that grabs n random records.

      Puppy |> Plasm.random(20) |> Repo.all
  """
  def random(query, n) do
    # TODO: support databases other than postgres
    query
    |> order_by([_], fragment("RANDOM()"))
    |> limit(^n)
  end

  @doc """
  Builds a sum query for a given field.

      Puppy |> Plasm.sum(:age) |> Repo.one
  """
  def sum(query, field_name) do
    query
    |> select([x], sum(field(x, ^field_name)))
  end

  @doc """
  Builds a query that finds all records updated after a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_after(ecto_date_time) |> Repo.all
  """
  def updated_after(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at > ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated after a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_after("2014-04-17T14:00:00Z") |> Repo.all
  """
  def updated_after(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_after(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated on or after a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_after_incl(ecto_date_time) |> Repo.all
  """
  def updated_after_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at >= ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated on or after a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_after_incl("2014-04-17T14:00:00Z") |> Repo.all
  """
  def updated_after_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_after_incl(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated before a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_before(ecto_date_time) |> Repo.all
  """
  def updated_before(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at < ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated before a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_before("2014-04-17T14:00:00Z") |> Repo.all
  """
  def updated_before(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_before(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated on or before a specified `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_before_incl(ecto_date_time) |> Repo.all
  """
  def updated_before_incl(query, %Ecto.DateTime{} = ecto_date_time) do
    query
    |> where([x], x.updated_at <= ^ecto_date_time)
  end

  @doc """
  Builds a query that finds all records updated on or before a specified string that is castable to `%Ecto.DateTime{}`.

      Puppy |> Plasm.updated_before_incl("2014-04-17T14:00:00Z") |> Repo.all
  """
  def updated_before_incl(query, castable) do
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable)
    query
    |> updated_before_incl(ecto_date_time)
  end

  @doc """
  Builds a query that finds all records matching all specified field names and values.

  Values can be lists or non-lists.

  When the values are all non-lists, it simply delegates to `Ecto.Query.where`.

  When there is at least one list value, it builds the query itself, using `in` for lists.

      Puppy |> Plasm.where_all(name: "Fluffy", age: 3) |> Repo.all

      Puppy |> Plasm.where_all(name: "Fluffy", age: [3,5,10]) |> Repo.all
  """
  def where_all(query, field_names_and_values) do
    contains_at_least_one_list = Keyword.values(field_names_and_values)
                                 |> Enum.any?(fn (value) -> is_list(value) end)
    query
    |> do_where_all(field_names_and_values, contains_at_least_one_list)
  end

  @doc """
  Builds a query that finds all records matching none of the specified field names and values.

  Values can be lists or non-lists.

  Non-list expressions result in a `!=` comparison.

  List expressions result in a `not in` comparison.

      Puppy |> Plasm.where_none(name: "Fluffy", age: 3) |> Repo.all

      Puppy |> Plasm.where_none(name: "Fluffy", age: [3,5,10]) |> Repo.all
  """
  def where_none(query, field_names_and_values) do
    Enum.reduce(field_names_and_values, query, fn ({field_name, field_value}, query) ->
      generate_where_clause_for_where_none(query, field_name, field_value)
    end)
  end

  # PRIVATE ######################################

  defp primary_key(query) do
    [key] = model(query).__schema__(:primary_key)
    key
  end

  defp model(%Ecto.Query{from: {_table_name, model_or_query}}) do
    model(model_or_query)
  end
  defp model(model), do: model

  defp generate_where_clause_for_where_all(query, field_name, field_value) when is_list(field_value) do
    query
    |> where([x], field(x, ^field_name) in ^field_value)
  end
  defp generate_where_clause_for_where_all(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) == ^field_value)
  end

  defp generate_where_clause_for_where_none(query, field_name, field_value) when is_list(field_value) do
    query
    |> where([x], not field(x, ^field_name) in ^field_value)
  end
  defp generate_where_clause_for_where_none(query, field_name, field_value) do
    query
    |> where([x], field(x, ^field_name) != ^field_value)
  end

  defp do_where_all(query, field_names_and_values, true) do
    Enum.reduce(field_names_and_values, query, fn ({field_name, field_value}, query) ->
      generate_where_clause_for_where_all(query, field_name, field_value)
    end)
  end

  defp do_where_all(query, field_names_and_values, false) do
    query
    |> where(^field_names_and_values)
  end
end
