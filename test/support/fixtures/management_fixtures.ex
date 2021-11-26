defmodule ApiSandboxChallenge.ManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiSandboxChallenge.Management` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        enrollment_id: "some enrollment_id",
        institution: %{},
        last_four: "some last_four",
        links: %{},
        name: "some name",
        subtype: "some subtype",
        type: "some type"
      })
      |> ApiSandboxChallenge.Management.create_account()

    account
  end

  @doc """
  Generate a account_detail.
  """
  def account_detail_fixture(attrs \\ %{}) do
    {:ok, account_detail} =
      attrs
      |> Enum.into(%{
        account_id: "some account_id",
        account_number: "some account_number",
        links: %{},
        routing_numbers: %{}
      })
      |> ApiSandboxChallenge.Management.create_account_detail()

    account_detail
  end

  @doc """
  Generate a balance.
  """
  def balance_fixture(attrs \\ %{}) do
    {:ok, balance} =
      attrs
      |> Enum.into(%{
        account_id: "some account_id",
        available: "some available",
        ledger: "some ledger",
        links: %{}
      })
      |> ApiSandboxChallenge.Management.create_balance()

    balance
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        account_id: "some account_id",
        amount: "some amount",
        date: "some date",
        description: "some description",
        details: %{},
        id: "some id",
        links: %{},
        running_balance: "some running_balance",
        status: "some status",
        type: "some type"
      })
      |> ApiSandboxChallenge.Management.create_transaction()

    transaction
  end
end
