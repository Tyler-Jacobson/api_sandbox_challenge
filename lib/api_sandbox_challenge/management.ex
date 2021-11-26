defmodule ApiSandboxChallenge.Management do
  @moduledoc """
  The Management context.
  """

  import Ecto.Query, warn: false
  alias ApiSandboxChallenge.Repo

  alias ApiSandboxChallenge.Management.Account

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    # Repo.all(Account)
    [
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmf3f7758gpc7b5cd6000",
        id: "acc_nmfff743stmo5n80t4000",
        institution: %{
        institution_id: "citibank",
        name: "Citibank"
        },
        last_four: "3836",
        links: %{
        balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
        details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "My Checking",
        subtype: "checking",
        type: "depository"
       }
    ]
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
  def get_account!(id), do: Repo.get!(Account, id)

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
end
