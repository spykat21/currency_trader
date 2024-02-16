defmodule CurrencyTraderWeb.TransactionController do
  use CurrencyTraderWeb, :controller

  alias CurrencyTrader.{
    Transactions,
    Transactions.Transaction,
    Vaults,
    Currencies,
    Vaults.Vault,
    Vault_Transactions.Vault_Transaction,
    Vault_Transactions
  }

  alias CurrencyTraderWeb.Auth.ErrorResponse

  action_fallback CurrencyTraderWeb.FallbackController

  def index(conn, _params) do
    transactions = Transactions.list_transactions()
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    %{"action" => action} = transaction_params
    %{"rate" => rate} = transaction_params
    %{"amount" => amount} = transaction_params
    %{"currency_code" => currency_code} = transaction_params
    %{"agent_id" => agent_id} = transaction_params
    %{"exchange_currency_code" => exchange_currency_code} = transaction_params

    exchange = Decimal.from_float(amount * rate)

    case action do
      "buy" ->
        vaults = Vaults.get_vaults_by_agent_id!(agent_id)

        [agent_vault_ghs | _tail] =
          Enum.filter(vaults, fn vault -> vault.currency.curr_code == exchange_currency_code end)

        if Decimal.compare(agent_vault_ghs.amount, exchange) == :lt do
          raise ErrorResponse.Unprocessable,
            message: "Insufficient #{exchange_currency_code} balance to carry out transaction"
        else
          [agent_vault_usd | _tail] =
            Enum.filter(vaults, fn vault -> vault.currency.curr_code == currency_code end)

          new_transaction_params = Map.put(transaction_params, "exchange_amount", exchange)

          with {:ok, %Vault{} = _vault} <-
                 Vaults.update_vault(agent_vault_usd, %{
                   amount: Decimal.add(agent_vault_usd.amount, amount)
                 }),
               {:ok, %Vault{} = _vault} <-
                 Vaults.update_vault(agent_vault_ghs, %{
                   amount: Decimal.sub(agent_vault_ghs.amount, exchange)
                 }),
               {:ok, %Transaction{} = transaction} <-
                 Transactions.create_transaction(new_transaction_params),

          {:ok, %Vault_Transaction{} = _vault_transaction} <-
            Vault_Transactions.create_vault__transaction(transaction, %{
              agent_id: agent_id,
              currency_code: currency_code,
              amount: amount,
              type: "credit"
            }),

          {:ok, %Vault_Transaction{} = _vault_transaction} <-
            Vault_Transactions.create_vault__transaction(transaction, %{
              agent_id: agent_id,
              currency_code: exchange_currency_code,
              amount: transaction.exchange_amount,
              type: "debit"
            }) do
              render(conn, :show, transaction: transaction)
            end
        end

      "sell" ->
        ""
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <-
           Transactions.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transactions.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
