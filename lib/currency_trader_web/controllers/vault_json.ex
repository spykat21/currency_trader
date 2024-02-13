defmodule CurrencyTraderWeb.VaultJSON do
  alias CurrencyTrader.Vaults.Vault

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

  defp data(%Vault{} = vault) do
    %{
      id: vault.id,
      amount: vault.amount
    }
  end
end
