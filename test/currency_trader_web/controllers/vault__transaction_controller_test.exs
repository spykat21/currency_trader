defmodule CurrencyTraderWeb.Vault_TransactionControllerTest do
  use CurrencyTraderWeb.ConnCase

  import CurrencyTrader.Vault_TransactionsFixtures

  alias CurrencyTrader.Vault_Transactions.Vault_Transaction

  @create_attrs %{
    type: "some type",
    datetime: ~U[2024-02-14 17:42:00Z],
    currency_code: "some currency_code",
    amount: "120.5"
  }
  @update_attrs %{
    type: "some updated type",
    datetime: ~U[2024-02-15 17:42:00Z],
    currency_code: "some updated currency_code",
    amount: "456.7"
  }
  @invalid_attrs %{type: nil, datetime: nil, currency_code: nil, amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vault_transactions", %{conn: conn} do
      conn = get(conn, ~p"/api/vault_transactions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vault__transaction" do
    test "renders vault__transaction when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/vault_transactions", vault__transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/vault_transactions/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "120.5",
               "currency_code" => "some currency_code",
               "datetime" => "2024-02-14T17:42:00Z",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/vault_transactions", vault__transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vault__transaction" do
    setup [:create_vault__transaction]

    test "renders vault__transaction when data is valid", %{
      conn: conn,
      vault__transaction: %Vault_Transaction{id: id} = vault__transaction
    } do
      conn =
        put(conn, ~p"/api/vault_transactions/#{vault__transaction}",
          vault__transaction: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/vault_transactions/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "456.7",
               "currency_code" => "some updated currency_code",
               "datetime" => "2024-02-15T17:42:00Z",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      vault__transaction: vault__transaction
    } do
      conn =
        put(conn, ~p"/api/vault_transactions/#{vault__transaction}",
          vault__transaction: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vault__transaction" do
    setup [:create_vault__transaction]

    test "deletes chosen vault__transaction", %{
      conn: conn,
      vault__transaction: vault__transaction
    } do
      conn = delete(conn, ~p"/api/vault_transactions/#{vault__transaction}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/vault_transactions/#{vault__transaction}")
      end
    end
  end

  defp create_vault__transaction(_) do
    vault__transaction = vault__transaction_fixture()
    %{vault__transaction: vault__transaction}
  end
end
