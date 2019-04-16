# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Saz.Repo.insert!(%Saz.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Saz.{Humans, Animals}

Humans.create_person(%{
  "dob" => "1977-10-10",
  "name" => "John Doe",
  "native_language" => "Cantonese"
})

Humans.create_person(%{
  "dob" => "1989-02-23",
  "name" => "Jane Doe",
  "native_language" => "English"
})

Animals.create_pet(%{
  "dob" => "2010-01-01",
  "name" => "Pants",
  "gender" => "F",
  "species" => "Dog",
  "breed" => "Corgi",
  "person_id" => 1
})

Animals.create_pet(%{
  "dob" => "2011-11-01",
  "name" => "Robert Redford",
  "gender" => "M",
  "species" => "Dog",
  "breed" => "Rottweiler",
  "person_id" => 1
})

Animals.create_pet(%{
  "dob" => "2010-01-01",
  "name" => "Ruffles",
  "gender" => "M",
  "species" => "Cat",
  "breed" => "Russian Blue",
  "person_id" => 1
})

Animals.create_pet(%{
  "dob" => "2010-01-01",
  "name" => "Porgy",
  "gender" => "F",
  "species" => "Dog",
  "breed" => "N/A",
  "person_id" => 2
})

Animals.create_pet(%{
  "dob" => "2010-01-01",
  "name" => "Slippery Pete",
  "gender" => "M",
  "species" => "Gecko",
  "breed" => "N/A",
  "person_id" => 2
})
