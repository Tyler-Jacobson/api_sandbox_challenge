defmodule ApiSandboxChallenge.Management do
  @moduledoc """
  The Management context.
  """

  import Ecto.Query, warn: false
  alias ApiSandboxChallenge.Repo

  alias ApiSandboxChallenge.Management.Account

  alias ApiSandboxChallenge.DataGenerators.AccountDataGenerator


  def parse_token(token) do
    split_token = String.split(token, "_")
    seed = Enum.at(split_token, 2)
    String.to_integer(seed)
  end
  @doc """
  Returns the list of accounts.


  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts(seed) do
    # Repo.all(Account)
    AccountDataGenerator.all_accounts(seed)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id, seed) do
    # Repo.get!(Account, id)
    AccountDataGenerator.get_account(id, seed)
  end

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end

  alias ApiSandboxChallenge.Management.AccountDetail

  @doc """
  Returns the list of account_details.

  ## Examples

      iex> list_account_details()
      [%AccountDetail{}, ...]

  """
  def list_account_details do
    Repo.all(AccountDetail)
  end

  @doc """
  Gets a single account_detail.

  Raises `Ecto.NoResultsError` if the Account detail does not exist.

  ## Examples

      iex> get_account_detail!(123)
      %AccountDetail{}

      iex> get_account_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account_detail!(id) do
    # Repo.get!(AccountDetail, id)
    AccountDataGenerator.get_account_details(id)
  end

  @doc """
  Creates a account_detail.

  ## Examples

      iex> create_account_detail(%{field: value})
      {:ok, %AccountDetail{}}

      iex> create_account_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account_detail(attrs \\ %{}) do
    %AccountDetail{}
    |> AccountDetail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account_detail.

  ## Examples

      iex> update_account_detail(account_detail, %{field: new_value})
      {:ok, %AccountDetail{}}

      iex> update_account_detail(account_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_detail(%AccountDetail{} = account_detail, attrs) do
    account_detail
    |> AccountDetail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account_detail.

  ## Examples

      iex> delete_account_detail(account_detail)
      {:ok, %AccountDetail{}}

      iex> delete_account_detail(account_detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account_detail(%AccountDetail{} = account_detail) do
    Repo.delete(account_detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account_detail changes.

  ## Examples

      iex> change_account_detail(account_detail)
      %Ecto.Changeset{data: %AccountDetail{}}

  """
  def change_account_detail(%AccountDetail{} = account_detail, attrs \\ %{}) do
    AccountDetail.changeset(account_detail, attrs)
  end

  alias ApiSandboxChallenge.Management.Balance

  @doc """
  Returns the list of balances.

  ## Examples

      iex> list_balances()
      [%Balance{}, ...]

  """
  def list_balances do
    Repo.all(Balance)
  end

  @doc """
  Gets a single balance.

  Raises `Ecto.NoResultsError` if the Balance does not exist.

  ## Examples

      iex> get_balance!(123)
      %Balance{}

      iex> get_balance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_balance!(id) do
    # Repo.get!(Balance, id)

    AccountDataGenerator.get_balance_details(id)
  end

  @doc """
  Creates a balance.

  ## Examples

      iex> create_balance(%{field: value})
      {:ok, %Balance{}}

      iex> create_balance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_balance(attrs \\ %{}) do
    %Balance{}
    |> Balance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a balance.

  ## Examples

      iex> update_balance(balance, %{field: new_value})
      {:ok, %Balance{}}

      iex> update_balance(balance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_balance(%Balance{} = balance, attrs) do
    balance
    |> Balance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a balance.

  ## Examples

      iex> delete_balance(balance)
      {:ok, %Balance{}}

      iex> delete_balance(balance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_balance(%Balance{} = balance) do
    Repo.delete(balance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking balance changes.

  ## Examples

      iex> change_balance(balance)
      %Ecto.Changeset{data: %Balance{}}

  """
  def change_balance(%Balance{} = balance, attrs \\ %{}) do
    Balance.changeset(balance, attrs)
  end

  alias ApiSandboxChallenge.Management.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions!(id) do
    # Repo.all(Transaction)
    AccountDataGenerator.all_transactions(id)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id, transaction_id) do
    # Repo.get!(Transaction, id)
    AccountDataGenerator.get_transaction(id, transaction_id)
  end

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
