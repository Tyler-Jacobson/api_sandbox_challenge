defmodule ApiSandboxChallenge.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :account_id, :string
      add :amount, :string
      add :date, :string
      add :description, :string
      add :details, :map
      add :id, :string
      add :links, :map
      add :running_balance, :string
      add :status, :string
      add :type, :string

      timestamps()
    end
  end
end
