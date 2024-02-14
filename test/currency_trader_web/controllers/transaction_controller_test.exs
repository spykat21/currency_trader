defmodule CurrencyTraderWeb.TransactionControllerTest do
  use CurrencyTraderWeb.ConnCase

  import CurrencyTrader.TransactionsFixtures

  alias CurrencyTrader.Transactions.Transaction

  @create_attrs %{
    action: "some action",
    currency_code: "some currency_code",
    rate: "120.5",
    customer_name: "some customer_name",
    customer_phone: "some customer_phone",
    amount: "120.5",
    date_time: ~U[2024-02-13 09:52:00Z]
  }
  @update_attrs %{
    action: "some updated action",
    currency_code: "some updated currency_code",
    rate: "456.7",
    customer_name: "some updated customer_name",
    customer_phone: "some updated customer_phone",
    amount: "456.7",
    date_time: ~U[2024-02-14 09:52:00Z]
  }
  @invalid_attrs %{action: nil, currency_code: nil, rate: nil, customer_name: nil, customer_phone: nil, amount: nil, date_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, ~p"/api/transactions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "action" => "some action",
               "amount" => "120.5",
               "currency_code" => "some currency_code",
               "customer_name" => "some customer_name",
               "customer_phone" => "some customer_phone",
               "date_time" => "2024-02-13T09:52:00Z",
               "rate" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{conn: conn, transaction: %Transaction{id: id} = transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "action" => "some updated action",
               "amount" => "456.7",
               "currency_code" => "some updated currency_code",
               "customer_name" => "some updated customer_name",
               "customer_phone" => "some updated customer_phone",
               "date_time" => "2024-02-14T09:52:00Z",
               "rate" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, ~p"/api/transactions/#{transaction}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/transactions/#{transaction}")
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
