defmodule CurrencyTrader.Vault_Transactions.Vault_Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "vault_transactions" do
    field :type, :string
    field :currency_code, :string
    field :amount, :decimal
    belongs_to :transaction, CurrencyTrader.Transactions.Transaction
    belongs_to :agent, CurrencyTrader.Agents.Agent

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vault__transaction, attrs) do
    vault__transaction
    |> cast(attrs, [:agent_id, :transaction_id, :currency_code, :amount, :type])
    |> validate_required([:agent_id, :transaction_id, :currency_code, :amount, :type])
    |> validate_number(:amount, greater_than: 0)
  end
end
