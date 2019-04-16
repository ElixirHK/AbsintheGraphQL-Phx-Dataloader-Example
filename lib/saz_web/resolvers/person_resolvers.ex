defmodule SazWeb.Resolvers.Person do
  alias Saz.{Humans, Animals}
  import Absinthe.Resolution.Helpers

  # Root = Results from previous/parent type
  # Args = Arguments
  # Context = Mutable object provided to all resolvers, may include headers/auth info

  def list_persons(_root, args, _context) do
    {:ok, Humans.list_persons(args)}
  end

  def person_by_id(_, %{id: id}, _) do
    case Humans.get_person!(id) do
      {:error, reason} ->
        {:error, reason}
      result ->
        {:ok, result}
    end
  end

  def create_person(_, %{input: params}, _) do
    case Humans.create_person(params) do
      {:ok, person} ->
        {:ok, %{person: person}}
      {:error, reason} ->
        {:error, reason}
      _ ->
        #TODO log unexpected results here
    end
  end

  def update_person(_, %{person_id: person_id, input: params}, _) do
    person = Humans.get_person!(person_id)

    case Humans.update_person(person, params) do
      {:ok, updated_person} ->
        {:ok, %{person: updated_person}}
      {:error, reason} ->
        {:error, reason}
      _ ->
        # TODO log unexpected results here
    end
  end

end
