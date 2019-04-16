defmodule SazWeb.Resolvers.Pet do
  alias Saz.{Humans, Animals}
  import Absinthe.Resolution.Helpers

  # Root = Results from previous/parent type
  # Args = Arguments
  # Context = Mutable object provided to all resolvers, may include headers/auth info

  def list_pets(_root, args, _context) do
    {:ok, Animals.list_pets(args)}
  end

  def pet_by_id(_, %{id: id}, _) do
    case Animals.get_pet!(id) do
      {:error, reason} ->
        {:error, reason}
      result ->
        {:ok, result}
    end
  end

  def create_pet(_, %{input: params}, _) do
    case Animals.create_pet(params) do
      {:ok, pet} ->
        {:ok, %{pet: pet}}
      {:error, reason} ->
        {:error, reason}
      _ ->
        #TODO log unexpected results here
    end
  end

  def update_pet(_, %{pet_id: pet_id, input: params}, _) do
    pet = Animals.get_pet!(pet_id)

    case Animals.update_pet(pet, params) do
      {:ok, updated_pet} ->
        {:ok, %{pet: updated_pet}}
      {:error, reason} ->
        {:error, reason}
      _ ->
        # TODO log unexpected results here
    end
  end

end
