defmodule ApiSandboxChallenge.Management.AccountDetail do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :account_id, :string
    field :account_number, :string
    field :links, :map
    field :routing_numbers, :map

    timestamps()
  end

  @doc false
  def changeset(account_detail, attrs) do
    account_detail
    |> cast(attrs, [:account_id, :account_number, :links, :routing_numbers])
    |> validate_required([:account_id, :account_number, :links, :routing_numbers])
  end
end
