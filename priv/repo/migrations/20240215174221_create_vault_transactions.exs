defmodule CurrencyTrader.Repo.Migrations.CreateVaultTransactions do
  use Ecto.Migration

  def change do
    create table(:vault_transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :currency_code, :string
      add :amount, :decimal
      add :type, :string
      add :agent_id, references(:agents, on_delete: :nothing, type: :binary_id)
      add :transaction_id, references(:transactions, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:vault_transactions, [:agent_id])
    create index(:vault_transactions, [:transaction_id])
  end
end
