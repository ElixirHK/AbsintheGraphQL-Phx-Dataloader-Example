defmodule Saz.Animals.Pet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Saz.Humans.Person

  schema "pets" do
    field :breed, :string
    field :dob, :date
    field :gender, :string
    field :name, :string
    field :species, :string
    belongs_to :person, Person

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :breed, :gender, :dob, :species, :person_id])
    |> validate_required([:name, :species, :gender, :dob])
  end
end
