defmodule Saz.Humans do
  @moduledoc """
  The Humans context.
  """

  import Ecto.Query, warn: false
  alias Saz.Repo

  alias Saz.Humans.Person

  # DataLoader Functions

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, args) do
    case queryable do
      Person -> persons_query(args)
      queryable -> queryable
    end
  end

  def list_persons(args) do
    args
    |> persons_query
    |> Repo.all
  end

  defp persons_query(args) do
    Enum.reduce(args, Person, fn
    {:filter, filter}, query ->
      query |> person_filter(filter)
    end)
  end

  defp person_filter(query, filter) do
    Enum.reduce(filter, query, fn
      {:dob, dob}, query ->
        from q in query, where: q.dob == ^dob
      {:name, name}, query ->
        from q in query, where: q.name == ^name
      {:id, id}, query ->
        from q in query, where: q.id == ^id
      {:native_language, native_language}, query ->
        from q in query, where: q.native_language == ^native_language
    end)
  end

  @doc """
  Returns the list of persons.

  ## Examples

      iex> list_persons()
      [%Person{}, ...]

  """
  def list_persons do
    Repo.all(Person)
  end

  @doc """
  Gets a single person.

  Raises `Ecto.NoResultsError` if the Person does not exist.

  ## Examples

      iex> get_person!(123)
      %Person{}

      iex> get_person!(456)
      ** (Ecto.NoResultsError)

  """
  def get_person!(id), do: Repo.get!(Person, id)

  @doc """
  Creates a person.

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_person(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a person.

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_person(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Person.

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  def delete_person(%Person{} = person) do
    Repo.delete(person)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking person changes.

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{source: %Person{}}

  """
  def change_person(%Person{} = person) do
    Person.changeset(person, %{})
  end
end
