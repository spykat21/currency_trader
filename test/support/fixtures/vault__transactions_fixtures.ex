defmodule CurrencyTrader.Vault_TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CurrencyTrader.Vault_Transactions` context.
  """

  @doc """
  Generate a vault__transaction.
  """
  def vault__transaction_fixture(attrs \\ %{}) do
    {:ok, vault__transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        currency_code: "some currency_code",
        datetime: ~U[2024-02-14 17:42:00Z],
        type: "some type"
      })
      |> CurrencyTrader.Vault_Transactions.create_vault__transaction()

    vault__transaction
  end
end
