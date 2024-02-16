defmodule CurrencyTraderWeb.Vault_TransactionController do
  use CurrencyTraderWeb, :controller

  alias CurrencyTrader.Vault_Transactions
  alias CurrencyTrader.Vault_Transactions.Vault_Transaction

  action_fallback CurrencyTraderWeb.FallbackController

  def index(conn, _params) do
    vault_transactions = Vault_Transactions.list_vault_transactions()
    render(conn, :index, vault_transactions: vault_transactions)
  end

  def create(conn, %{"vault__transaction" => vault__transaction_params}) do
    with {:ok, %Vault_Transaction{} = vault__transaction} <-
           Vault_Transactions.create_vault__transaction(vault__transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/vault_transactions/#{vault__transaction}")
      |> render(:show, vault__transaction: vault__transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    vault__transaction = Vault_Transactions.get_vault__transaction!(id)
    render(conn, :show, vault__transaction: vault__transaction)
  end

  def update(conn, %{"id" => id, "vault__transaction" => vault__transaction_params}) do
    vault__transaction = Vault_Transactions.get_vault__transaction!(id)

    with {:ok, %Vault_Transaction{} = vault__transaction} <-
           Vault_Transactions.update_vault__transaction(
             vault__transaction,
             vault__transaction_params
           ) do
      render(conn, :show, vault__transaction: vault__transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    vault__transaction = Vault_Transactions.get_vault__transaction!(id)

    with {:ok, %Vault_Transaction{}} <-
           Vault_Transactions.delete_vault__transaction(vault__transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
