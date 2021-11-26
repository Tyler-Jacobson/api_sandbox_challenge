defmodule ApiSandboxChallenge.Management.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :account_id, :string
    field :amount, :string
    field :date, :string
    field :description, :string
    field :details, :map
    field :transaction_id, :string
    field :links, :map
    field :running_balance, :string
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:account_id, :amount, :date, :description, :details, :transaction_id, :links, :running_balance, :status, :type])
    |> validate_required([:account_id, :amount, :date, :description, :details, :transaction_id, :links, :running_balance, :status, :type])
  end
end
