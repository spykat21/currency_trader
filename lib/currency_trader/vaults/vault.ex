defmodule CurrencyTrader.Vaults.Vault do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "vaults" do
    field :amount, :decimal
    belongs_to :currency, CurrencyTrader.Currencies.Currency
    belongs_to :agent, CurrencyTrader.Agents.Agent

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vault, attrs) do
    vault
    |> cast(attrs, [:currency_id, :agent_id, :amount])
    |> validate_required([:currency_id, :agent_id, :amount])
  end
end
