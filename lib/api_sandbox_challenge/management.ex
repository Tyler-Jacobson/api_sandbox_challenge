defmodule ApiSandboxChallenge.Management do
  @moduledoc """
  The Management context.
  """

  import Ecto.Query, warn: false
  alias ApiSandboxChallenge.Repo

  alias ApiSandboxChallenge.Management.Account

  alias ApiSandboxChallenge.DataGenerators.AccountGenerators


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
    AccountGenerators.all_accounts(seed)
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
  def get_account!(account_id, seed) do
    AccountGenerators.get_account(seed, account_id)
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
  def get_account_detail!(account_id, seed) do
    AccountGenerators.get_account_details(seed, account_id)
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
  def get_balance!(account_id, seed) do
    AccountGenerators.get_balance_details(seed, account_id)
  end

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions!(seed, account_id) do
    AccountGenerators.all_transactions(account_id, seed)
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
  def get_transaction!(id, transaction_id, seed) do
    AccountGenerators.get_transaction(seed, id, transaction_id)
  end
end
