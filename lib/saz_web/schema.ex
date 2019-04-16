defmodule SazWeb.Schema do
  use Absinthe.Schema

  import_types SazWeb.Schema.{PersonTypes, PetTypes}
  import_types Absinthe.Type.Custom

  alias Saz.{Humans, Animals}
  alias SazWeb.Resolvers

  query do
    import_fields :person_queries
    import_fields :pet_queries
  end

  mutation do
    import_fields :person_mutations
    import_fields :pet_mutations
  end

  @desc "An error encountered trying to persist input"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  def context(ctx) do
    loader =
      Dataloader.new
      |> Dataloader.add_source(Humans, Humans.data())
      |> Dataloader.add_source(Animals, Animals.data())
    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  defp apply(middleware, _, _, _) do
    middleware
  end

end
