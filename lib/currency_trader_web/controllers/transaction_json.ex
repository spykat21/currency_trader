defmodule CurrencyTraderWeb.TransactionJSON do
  alias CurrencyTrader.Transactions.Transaction

  @doc """
  Renders a list of transactions.
  """
  def index(%{transactions: transactions}) do
    %{data: for(transaction <- transactions, do: data(transaction))}
  end

  @doc """
  Renders a single transaction.
  """
  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      base_currency: transaction.currency_code,
      quote_currency: transaction.exchange_currency_code,
      action: transaction.action,
      rate: transaction.rate,
      customer_name: transaction.customer_name,
      customer_phone: transaction.customer_phone,
      amount: transaction.amount,
      exchange_amount: transaction.exchange_amount,
      date_time: transaction.inserted_at
    }
  end
end
