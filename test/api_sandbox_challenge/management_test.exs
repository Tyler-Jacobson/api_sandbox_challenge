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

  describe "account_details" do
    alias ApiSandboxChallenge.Management.AccountDetail

    import ApiSandboxChallenge.ManagementFixtures

    @invalid_attrs %{account_id: nil, account_number: nil, links: nil, routing_numbers: nil}

    test "list_account_details/0 returns all account_details" do
      account_detail = account_detail_fixture()
      assert Management.list_account_details() == [account_detail]
    end

    test "get_account_detail!/1 returns the account_detail with given id" do
      account_detail = account_detail_fixture()
      assert Management.get_account_detail!(account_detail.id) == account_detail
    end

    test "create_account_detail/1 with valid data creates a account_detail" do
      valid_attrs = %{account_id: "some account_id", account_number: "some account_number", links: %{}, routing_numbers: %{}}

      assert {:ok, %AccountDetail{} = account_detail} = Management.create_account_detail(valid_attrs)
      assert account_detail.account_id == "some account_id"
      assert account_detail.account_number == "some account_number"
      assert account_detail.links == %{}
      assert account_detail.routing_numbers == %{}
    end

    test "create_account_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_account_detail(@invalid_attrs)
    end

    test "update_account_detail/2 with valid data updates the account_detail" do
      account_detail = account_detail_fixture()
      update_attrs = %{account_id: "some updated account_id", account_number: "some updated account_number", links: %{}, routing_numbers: %{}}

      assert {:ok, %AccountDetail{} = account_detail} = Management.update_account_detail(account_detail, update_attrs)
      assert account_detail.account_id == "some updated account_id"
      assert account_detail.account_number == "some updated account_number"
      assert account_detail.links == %{}
      assert account_detail.routing_numbers == %{}
    end

    test "update_account_detail/2 with invalid data returns error changeset" do
      account_detail = account_detail_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_account_detail(account_detail, @invalid_attrs)
      assert account_detail == Management.get_account_detail!(account_detail.id)
    end

    test "delete_account_detail/1 deletes the account_detail" do
      account_detail = account_detail_fixture()
      assert {:ok, %AccountDetail{}} = Management.delete_account_detail(account_detail)
      assert_raise Ecto.NoResultsError, fn -> Management.get_account_detail!(account_detail.id) end
    end

    test "change_account_detail/1 returns a account_detail changeset" do
      account_detail = account_detail_fixture()
      assert %Ecto.Changeset{} = Management.change_account_detail(account_detail)
    end
  end

  describe "balances" do
    alias ApiSandboxChallenge.Management.Balance

    import ApiSandboxChallenge.ManagementFixtures

    @invalid_attrs %{account_id: nil, available: nil, ledger: nil, links: nil}

    test "list_balances/0 returns all balances" do
      balance = balance_fixture()
      assert Management.list_balances() == [balance]
    end

    test "get_balance!/1 returns the balance with given id" do
      balance = balance_fixture()
      assert Management.get_balance!(balance.id) == balance
    end

    test "create_balance/1 with valid data creates a balance" do
      valid_attrs = %{account_id: "some account_id", available: "some available", ledger: "some ledger", links: %{}}

      assert {:ok, %Balance{} = balance} = Management.create_balance(valid_attrs)
      assert balance.account_id == "some account_id"
      assert balance.available == "some available"
      assert balance.ledger == "some ledger"
      assert balance.links == %{}
    end

    test "create_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_balance(@invalid_attrs)
    end

    test "update_balance/2 with valid data updates the balance" do
      balance = balance_fixture()
      update_attrs = %{account_id: "some updated account_id", available: "some updated available", ledger: "some updated ledger", links: %{}}

      assert {:ok, %Balance{} = balance} = Management.update_balance(balance, update_attrs)
      assert balance.account_id == "some updated account_id"
      assert balance.available == "some updated available"
      assert balance.ledger == "some updated ledger"
      assert balance.links == %{}
    end

    test "update_balance/2 with invalid data returns error changeset" do
      balance = balance_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_balance(balance, @invalid_attrs)
      assert balance == Management.get_balance!(balance.id)
    end

    test "delete_balance/1 deletes the balance" do
      balance = balance_fixture()
      assert {:ok, %Balance{}} = Management.delete_balance(balance)
      assert_raise Ecto.NoResultsError, fn -> Management.get_balance!(balance.id) end
    end

    test "change_balance/1 returns a balance changeset" do
      balance = balance_fixture()
      assert %Ecto.Changeset{} = Management.change_balance(balance)
    end
  end

  describe "transactions" do
    alias ApiSandboxChallenge.Management.Transaction

    import ApiSandboxChallenge.ManagementFixtures

    @invalid_attrs %{account_id: nil, amount: nil, date: nil, description: nil, details: nil, id: nil, links: nil, running_balance: nil, status: nil, type: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Management.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Management.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{account_id: "some account_id", amount: "some amount", date: "some date", description: "some description", details: %{}, id: "some id", links: %{}, running_balance: "some running_balance", status: "some status", type: "some type"}

      assert {:ok, %Transaction{} = transaction} = Management.create_transaction(valid_attrs)
      assert transaction.account_id == "some account_id"
      assert transaction.amount == "some amount"
      assert transaction.date == "some date"
      assert transaction.description == "some description"
      assert transaction.details == %{}
      assert transaction.id == "some id"
      assert transaction.links == %{}
      assert transaction.running_balance == "some running_balance"
      assert transaction.status == "some status"
      assert transaction.type == "some type"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Management.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{account_id: "some updated account_id", amount: "some updated amount", date: "some updated date", description: "some updated description", details: %{}, id: "some updated id", links: %{}, running_balance: "some updated running_balance", status: "some updated status", type: "some updated type"}

      assert {:ok, %Transaction{} = transaction} = Management.update_transaction(transaction, update_attrs)
      assert transaction.account_id == "some updated account_id"
      assert transaction.amount == "some updated amount"
      assert transaction.date == "some updated date"
      assert transaction.description == "some updated description"
      assert transaction.details == %{}
      assert transaction.id == "some updated id"
      assert transaction.links == %{}
      assert transaction.running_balance == "some updated running_balance"
      assert transaction.status == "some updated status"
      assert transaction.type == "some updated type"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Management.update_transaction(transaction, @invalid_attrs)
      assert transaction == Management.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Management.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Management.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Management.change_transaction(transaction)
    end
  end
end
