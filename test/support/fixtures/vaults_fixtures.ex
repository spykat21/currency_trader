defmodule CurrencyTrader.VaultsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CurrencyTrader.Vaults` context.
  """

  @doc """
  Generate a vault.
  """
  def vault_fixture(attrs \\ %{}) do
    {:ok, vault} =
      attrs
      |> Enum.into(%{
        amount: "120.5"
      })
      |> CurrencyTrader.Vaults.create_vault()

    vault
  end
end
