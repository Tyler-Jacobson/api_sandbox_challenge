defmodule ApiSandboxChallenge.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :account_id, :string
      add :available, :string
      add :ledger, :string
      add :links, :map

      timestamps()
    end
  end
end
