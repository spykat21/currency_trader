defmodule CurrencyTrader.CurrenciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CurrencyTrader.Currencies` context.
  """

  @doc """
  Generate a currency.
  """
  def currency_fixture(attrs \\ %{}) do
    {:ok, currency} =
      attrs
      |> Enum.into(%{
        buy_rate: "120.5",
        currency: "some currency",
        sell_rate: "120.5",
        updated_by: "some updated_by"
      })
      |> CurrencyTrader.Currencies.create_currency()

    currency
  end
end
