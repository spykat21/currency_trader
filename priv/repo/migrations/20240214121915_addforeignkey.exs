defmodule CurrencyTrader.Repo.Migrations.Addforeignkey do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :agent_id, references(:agents, on_delete: :nothing, type: :binary_id)
    end
  end
end
