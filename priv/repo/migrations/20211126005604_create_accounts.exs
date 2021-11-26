defmodule ApiSandboxChallenge.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :currency, :string
      add :enrollment_id, :string
      add :institution, :map
      add :last_four, :string
      add :links, :map
      add :name, :string
      add :subtype, :string
      add :type, :string

      timestamps()
    end
  end
end
