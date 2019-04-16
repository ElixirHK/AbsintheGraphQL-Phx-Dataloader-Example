defmodule Saz.ShopTest do
  use Saz.DataCase

  alias Saz.Shop

  describe "stores" do
    alias Saz.Shop.Store

    @valid_attrs %{address: "some address", name: "some name", phone: "some phone"}
    @update_attrs %{address: "some updated address", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, name: nil, phone: nil}

    def store_fixture(attrs \\ %{}) do
      {:ok, store} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_store()

      store
    end

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert Shop.list_stores() == [store]
    end

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert Shop.get_store!(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      assert {:ok, %Store{} = store} = Shop.create_store(@valid_attrs)
      assert store.address == "some address"
      assert store.name == "some name"
      assert store.phone == "some phone"
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      assert {:ok, %Store{} = store} = Shop.update_store(store, @update_attrs)
      assert store.address == "some updated address"
      assert store.name == "some updated name"
      assert store.phone == "some updated phone"
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_store(store, @invalid_attrs)
      assert store == Shop.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = Shop.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = Shop.change_store(store)
    end
  end
end
