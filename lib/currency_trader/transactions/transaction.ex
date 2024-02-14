defmodule CurrencyTrader.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :action, :string
    field :currency_code, :string
    field :rate, :decimal
    field :customer_name, :string
    field :customer_phone, :string
    field :amount, :decimal
    field :date_time, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:currency_code, :action, :rate, :customer_name, :customer_phone, :amount, :date_time])
    |> validate_required([:currency_code, :action, :rate, :customer_name, :customer_phone, :amount, :date_time])
  end
end
