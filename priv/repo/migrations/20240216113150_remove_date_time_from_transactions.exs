defmodule CurrencyTrader.Repo.Migrations.RemoveDateTimeFromTransactions do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      drop :date_time
    end
  end
end
