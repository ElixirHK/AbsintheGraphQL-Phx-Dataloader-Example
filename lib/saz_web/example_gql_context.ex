# NOTE this is an example Context for Guardian JWTs

# defmodule SazWeb.GQLContext do
#   @behaviour Plug
#
#   import Plug.Conn
#   import Ecto.Query, only: [where: 2]
#
#   alias Saz.{Repo, User, Guardian}
#
#   def init(opts), do: opts
#
#   def call(conn, _) do
#     context = build_context(conn)
#     Absinthe.Plug.put_options(conn, context: context)
#   end
# 
#
#   @doc """
#   Return the current user context based on the authorization header
#   """
#   def build_context(conn) do
#     with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
#     {:ok, current_user} <- authorize(token) do
#       %{current_user: current_user}
#     else
#       _ -> %{}
#     end
#   end
#
#   defp authorize(token) do
#
#     case Guardian.decode_and_verify(token) do
#       {:ok, claims} ->
#         user = Guardian.resource_from_claims(claims)
#         {:ok, user}
#       true -> {:error, "invalid request"}
#     end
#
#   end
#
# end
