defmodule CurrencyTrader.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :action, :string
    field :currency_code, :string
    field :exchange_currency_code, :string
    field :rate, :decimal
    field :customer_name, :string
    field :customer_phone, :string
    field :amount, :decimal
    field :exchange_amount, :decimal
    has_many :vault_transactions, CurrencyTrader.Vault_Transactions.Vault_Transaction
    # :date_time, :utc_datetime, default: DateTime.utc_now(:second)
    belongs_to :agent, CurrencyTrader.Agents.Agent

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [
      :agent_id,
      :currency_code,
      :exchange_currency_code,
      :action,
      :rate,
      :customer_name,
      :customer_phone,
      :amount,
      :exchange_amount
    ])
    |> validate_required([
      :agent_id,
      :currency_code,
      :exchange_currency_code,
      :action,
      :rate,
      :customer_name,
      :customer_phone,
      :amount,
      :exchange_amount
    ])
    |> validate_number(:amount, greater_than: 0)
    |> validate_number(:exchange_amount, greater_than: 0)
    |> validate_number(:rate, greater_than: 0)
  end
end
