defmodule ApiSandboxChallenge.Management.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field :account_id, :string
    field :available, :string
    field :ledger, :string
    field :links, :map

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:account_id, :available, :ledger, :links])
    |> validate_required([:account_id, :available, :ledger, :links])
  end
end
