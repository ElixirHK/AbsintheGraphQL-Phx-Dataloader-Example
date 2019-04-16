defmodule SazWeb.Schema.PetTypes do
  use Absinthe.Schema.Notation

  alias SazWeb.Resolvers
  # Resolution.Helpers needed for dataloader
  import Absinthe.Resolution.Helpers

  @desc "Root pet object"
  object :pet do
    field :id, :id
    field :dob, :string
    field :name, :string
    field :gender, :string
    field :species, :string
    field :breed, :string
    field :person, :person do
      # Invocation of dataloader middleware for slick
      # querying
      resolve dataloader(Saz.Humans)
    end
  end

  @desc "Result object for creation of pets"
  object :pet_result do
    field :pet, :pet
    field :errors, list_of(:input_error)
  end

  @desc "Input object for creating pets"
  input_object :pet_input do
    field :dob, non_null(:string)
    field :name, non_null(:string)
    field :native_language, :string
  end

  object :pet_queries do
    @desc "List all pets"
    field :list_pets, list_of(:pet) do
      resolve &Resolvers.Pet.list_pets/3
    end

    @desc "Get pet by ID"
    field :pet_by_id, :pet do
      arg :id, non_null(:integer)
      resolve &Resolvers.Pet.pet_by_id/3
    end
  end

  object :pet_mutations do
    field :create_pet, :pet_result do
      arg :input, non_null(:pet_input)
      # NOTE Auth middleware may go here
      resolve &Resolvers.Pet.create_pet/3
    end
  end

end
