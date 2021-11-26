defmodule ApiSandboxChallenge.Management.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :currency, :string
    field :enrollment_id, :string
    field :institution, :map
    field :last_four, :string
    field :links, :map
    field :name, :string
    field :subtype, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:currency, :enrollment_id, :institution, :last_four, :links, :name, :subtype, :type])
    |> validate_required([:currency, :enrollment_id, :institution, :last_four, :links, :name, :subtype, :type])
  end
end
