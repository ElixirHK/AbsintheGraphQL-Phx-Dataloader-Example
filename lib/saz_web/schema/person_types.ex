defmodule SazWeb.Schema.PersonTypes do
  use Absinthe.Schema.Notation

  alias SazWeb.Resolvers
  # Resolution.Helpers needed for dataloader
  import Absinthe.Resolution.Helpers

  @desc "Root person object for records about humans"
  object :person do
    field :id, :id
    field :dob, :string
    field :name, :string
    field :native_language, :string
    field :pets, list_of(:pet) do
      # Invocation of dataloader middleware for slick
      # querying
      resolve dataloader(Saz.Animals)
    end
  end

  @desc "Result object for creation of persons"
  object :person_result do
    field :person, :person
    field :errors, list_of(:input_error)
  end

  @desc "Input object for creating persons"
  input_object :person_input do
    field :dob, non_null(:string)
    field :name, non_null(:string)
    field :native_language, :string
  end

  object :person_queries do
    @desc "List all persons"
    field :list_persons, list_of(:person) do
      resolve &Resolvers.Person.list_persons/3
    end

    @desc "Get person by ID"
    field :person_by_id, :person do
      arg :id, non_null(:integer)
      resolve &Resolvers.Person.person_by_id/3
    end
  end

  object :person_mutations do
    field :create_person, :person_result do
      arg :input, non_null(:person_input)
      # NOTE Auth middleware may go here
      resolve &Resolvers.Person.create_person/3
    end
  end

end
