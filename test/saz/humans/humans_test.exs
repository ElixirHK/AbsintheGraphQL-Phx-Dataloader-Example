defmodule Saz.HumansTest do
  use Saz.DataCase

  alias Saz.Humans

  describe "persons" do
    alias Saz.Humans.Person

    @valid_attrs %{dob: ~D[2010-04-17], name: "some name", native_language: "some native_language"}
    @update_attrs %{dob: ~D[2011-05-18], name: "some updated name", native_language: "some updated native_language"}
    @invalid_attrs %{dob: nil, name: nil, native_language: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Humans.create_person()

      person
    end

    test "list_persons/0 returns all persons" do
      person = person_fixture()
      assert Humans.list_persons() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Humans.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Humans.create_person(@valid_attrs)
      assert person.dob == ~D[2010-04-17]
      assert person.name == "some name"
      assert person.native_language == "some native_language"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Humans.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = Humans.update_person(person, @update_attrs)
      assert person.dob == ~D[2011-05-18]
      assert person.name == "some updated name"
      assert person.native_language == "some updated native_language"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Humans.update_person(person, @invalid_attrs)
      assert person == Humans.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Humans.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Humans.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Humans.change_person(person)
    end
  end
end
