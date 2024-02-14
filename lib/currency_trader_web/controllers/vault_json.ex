defmodule CurrencyTraderWeb.VaultJSON do
  alias CurrencyTrader.Vaults.Vault
  alias CurrencyTraderWeb.CurrencyJSON

  @doc """
  Renders a list of vaults.
  """
  def index(%{vaults: vaults}) do
    %{data: for(vault <- vaults, do: data(vault))}
  end

  @doc """
  Renders a single vault.
  """
  def show(%{vault: vault}) do
    %{data: data(vault)}
  end

  def data(%Vault{} = vault) do
    %{
      id: vault.id,
      amount: vault.amount,
      details: CurrencyJSON.data(vault.currency)
    }
  end
end
