defmodule SazWeb.Router do
  use SazWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/gql", Absinthe.Plug,
      schema: SazWeb.Schema,
      json_codec: Jason

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: SazWeb.Schema,
      json_codec: Jason
  end


end
