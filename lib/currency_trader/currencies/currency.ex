defmodule CurrencyTrader.Currencies.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "currencies" do
    field :curr_code, :string
    field :currency, :string
    field :buy_rate, :decimal
    field :sell_rate, :decimal
    field :updated_by, :string
    has_one :vault, CurrencyTrader.Vaults.Vault

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:curr_code, :currency, :buy_rate, :sell_rate, :updated_by])
    |> validate_required([:curr_code, :currency, :buy_rate, :sell_rate, :updated_by])
  end
end
