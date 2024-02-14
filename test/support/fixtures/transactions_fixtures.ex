defmodule CurrencyTrader.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CurrencyTrader.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        action: "some action",
        amount: "120.5",
        currency_code: "some currency_code",
        customer_name: "some customer_name",
        customer_phone: "some customer_phone",
        date_time: ~U[2024-02-13 09:52:00Z],
        rate: "120.5"
      })
      |> CurrencyTrader.Transactions.create_transaction()

    transaction
  end
end
