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
end
