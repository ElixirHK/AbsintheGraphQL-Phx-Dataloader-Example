defmodule Saz.Repo do
  use Ecto.Repo,
    otp_app: :saz,
    adapter: Ecto.Adapters.Postgres
end
