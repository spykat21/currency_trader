defmodule CurrencyTraderWeb.Vault_TransactionJSON do
  alias CurrencyTrader.Vault_Transactions.Vault_Transaction

  @doc """
  Renders a list of vault_transactions.
  """
  def index(%{vault_transactions: vault_transactions}) do
    %{data: for(vault__transaction <- vault_transactions, do: data(vault__transaction))}
  end

  @doc """
  Renders a single vault__transaction.
  """
  def show(%{vault__transaction: vault__transaction}) do
    %{data: data(vault__transaction)}
  end

  defp data(%Vault_Transaction{} = vault__transaction) do
    %{
      id: vault__transaction.id,
      currency_code: vault__transaction.currency_code,
      amount: vault__transaction.amount,
      type: vault__transaction.type
    }
  end
end
