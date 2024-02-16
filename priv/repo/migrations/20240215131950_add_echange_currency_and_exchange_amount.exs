defmodule CurrencyTrader.Repo.Migrations.AddEchangeCurrencyAndExchangeAmount do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :exchange_currency_code, :string
      add :exchange_amount, :decimal
    end
  end
end
