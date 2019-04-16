defmodule Saz.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :name, :string
      add :dob, :date
      add :native_language, :string

      timestamps()
    end

  end
end
