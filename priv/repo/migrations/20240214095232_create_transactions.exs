defmodule CurrencyTrader.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :currency_code, :string
      add :action, :string
      add :rate, :decimal
      add :customer_name, :string
      add :customer_phone, :string
      add :amount, :decimal
      add :date_time, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:transactions , [:currency_code])
  end
end
