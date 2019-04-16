defmodule Saz.Animals do
  @moduledoc """
  The Animals context.
  """

  import Ecto.Query, warn: false
  alias Saz.Repo

  alias Saz.Animals.Pet

  # DataLoader Functions

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, args) do
    case queryable do
      Pet -> pets_query(args)
      queryable -> queryable
    end
  end

  def list_pets(args) do
    args
    |> pets_query
    |> Repo.all
  end

  defp pets_query(args) do
    Enum.reduce(args, Pet, fn
    {:filter, filter}, query ->
      query |> pet_filter(filter)
    end)
  end

  defp pet_filter(query, filter) do
    Enum.reduce(filter, query, fn
      {:id, id}, query ->
        from q in query, where: q.id == ^id
      {:species, species}, query ->
        from q in query, where: q.species == ^species
      {:breed, breed}, query ->
        from q in query, where: q.breed == ^breed
      {:dob, dob}, query ->
        from q in query, where: q.dob == ^dob
      {:name, name}, query ->
        from q in query, where: q.name == ^name
      {:gender, gender}, query ->
        from q in query, where: q.gender == ^gender
    end)
  end

  @doc """
  Returns the list of pets.

  ## Examples

      iex> list_pets()
      [%Pet{}, ...]

  """
  def list_pets do
    Repo.all(Pet)
  end

  @doc """
  Gets a single pet.

  Raises `Ecto.NoResultsError` if the Pet does not exist.

  ## Examples

      iex> get_pet!(123)
      %Pet{}

      iex> get_pet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet!(id), do: Repo.get!(Pet, id)

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(attrs \\ %{}) do
    %Pet{}
    |> Pet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pet.

  ## Examples

      iex> update_pet(pet, %{field: new_value})
      {:ok, %Pet{}}

      iex> update_pet(pet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet(%Pet{} = pet, attrs) do
    pet
    |> Pet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Pet.

  ## Examples

      iex> delete_pet(pet)
      {:ok, %Pet{}}

      iex> delete_pet(pet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pet(%Pet{} = pet) do
    Repo.delete(pet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pet changes.

  ## Examples

      iex> change_pet(pet)
      %Ecto.Changeset{source: %Pet{}}

  """
  def change_pet(%Pet{} = pet) do
    Pet.changeset(pet, %{})
  end
end
