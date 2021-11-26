defmodule ApiSandboxChallenge.ManagementTest do
  use ApiSandboxChallenge.DataCase

  alias ApiSandboxChallenge.Management

  describe "accounts" do
    alias ApiSandboxChallenge.Management.Account

    import ApiSandboxChallenge.ManagementFixtures

    @invalid_attrs %{currency: nil, enrollment_id: nil, institution: nil, last_four: nil, links: nil, name: nil, subtype: nil, type: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Management.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Management.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{currency: "some currency", enrollment_id: "some enrollment_id", institution: %{}, last_four: "some last_four", links: %{}, name: "some name", subtype: "some subtype", type: "some type"}

      assert {:ok, %Account{} = account} = Management.create_account(valid_attrs)
      assert account.currency == "some currency"
      assert account.enrollment_id == "some enrollment_id"
      assert account.institution == %{}
      assert account.last_four == "some last_four"
      assert account.links == %{}
      assert account.name == "some name"
      assert account.subtype == "some subtype"
      assert account.type == "some type"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{currency: "some updated currency", enrollment_id: "some updated enrollment_id", institution: %{}, last_four: "some updated last_four", links: %{}, name: "some updated name", subtype: "some updated subtype", type: "some updated type"}

      assert {:ok, %Account{} = account} = Management.update_account(account, update_attrs)
      assert account.currency == "some updated currency"
      assert account.enrollment_id == "some updated enrollment_id"
      assert account.institution == %{}
      assert account.last_four == "some updated last_four"
      assert account.links == %{}
      assert account.name == "some updated name"
      assert account.subtype == "some updated subtype"
      assert account.type == "some updated type"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_account(account, @invalid_attrs)
      assert account == Management.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Management.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Management.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Management.change_account(account)
    end
  end
end
