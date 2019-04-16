defmodule Saz.Humans.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Saz.Animals.Pet

  schema "persons" do
    field :dob, :date
    field :name, :string
    field :native_language, :string
    has_many :pets, Pet

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :dob, :native_language])
    |> validate_required([:name, :dob])
  end
end
