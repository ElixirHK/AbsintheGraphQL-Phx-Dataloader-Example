defmodule Saz.Repo.Migrations.CreatePets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string
      add :breed, :string
      add :gender, :string
      add :dob, :date
      add :species, :string
      add :person_id, references(:persons, on_delete: :nothing)

      timestamps()
    end

    create index(:pets, [:person_id])
  end
end
