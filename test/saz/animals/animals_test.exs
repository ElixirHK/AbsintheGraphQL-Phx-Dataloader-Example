defmodule Saz.AnimalsTest do
  use Saz.DataCase

  alias Saz.Animals

  describe "pets" do
    alias Saz.Animals.Pet

    @valid_attrs %{breed: "some breed", dob: ~D[2010-04-17], name: "some name"}
    @update_attrs %{breed: "some updated breed", dob: ~D[2011-05-18], name: "some updated name"}
    @invalid_attrs %{breed: nil, dob: nil, name: nil}

    def pet_fixture(attrs \\ %{}) do
      {:ok, pet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Animals.create_pet()

      pet
    end

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert Animals.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert Animals.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      assert {:ok, %Pet{} = pet} = Animals.create_pet(@valid_attrs)
      assert pet.breed == "some breed"
      assert pet.dob == ~D[2010-04-17]
      assert pet.name == "some name"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Animals.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{} = pet} = Animals.update_pet(pet, @update_attrs)
      assert pet.breed == "some updated breed"
      assert pet.dob == ~D[2011-05-18]
      assert pet.name == "some updated name"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = Animals.update_pet(pet, @invalid_attrs)
      assert pet == Animals.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = Animals.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> Animals.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = Animals.change_pet(pet)
    end
  end
end
