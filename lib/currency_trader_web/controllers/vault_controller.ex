defmodule CurrencyTraderWeb.VaultController do
  use CurrencyTraderWeb, :controller

  alias CurrencyTrader.Vaults
  alias CurrencyTrader.Vaults.Vault

  action_fallback CurrencyTraderWeb.FallbackController

  def index(conn, _params) do
    vaults = Vaults.list_vaults()
    render(conn, :index, vaults: vaults)
  end

  def create(conn, %{"vault" => vault_params}) do
    with {:ok, %Vault{} = vault} <- Vaults.add_vault(vault_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", ~p"/api/vaults/#{vault}")
      |> render(:show, vault: vault)
    end
  end

  def show(conn, %{"id" => id}) do
    vault = Vaults.get_vault!(id)
    render(conn, :show, vault: vault)
  end


  def update(conn, %{"id" => id, "vault" => vault_params}) do
    vault = Vaults.get_vault!(id)

    with {:ok, %Vault{} = vault} <- Vaults.update_vault(vault, vault_params) do
      render(conn, :show, vault: vault)
    end
  end

  def delete(conn, %{"id" => id}) do
    vault = Vaults.get_vault!(id)

    with {:ok, %Vault{}} <- Vaults.delete_vault(vault) do
      send_resp(conn, :no_content, "")
    end
  end
end
