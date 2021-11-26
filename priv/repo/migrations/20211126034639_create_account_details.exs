defmodule ApiSandboxChallenge.Repo.Migrations.CreateAccountDetails do
  use Ecto.Migration

  def change do
    create table(:account_details) do
      add :account_id, :string
      add :account_number, :string
      add :links, :map
      add :routing_numbers, :map

      timestamps()
    end
  end
end
