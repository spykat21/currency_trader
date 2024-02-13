defmodule CurrencyTraderWeb.CurrencyControllerTest do
  use CurrencyTraderWeb.ConnCase

  import CurrencyTrader.CurrenciesFixtures

  alias CurrencyTrader.Currencies.Currency

  @create_attrs %{
    currency: "some currency",
    buy_rate: "120.5",
    sell_rate: "120.5",
    updated_by: "some updated_by"
  }
  @update_attrs %{
    currency: "some updated currency",
    buy_rate: "456.7",
    sell_rate: "456.7",
    updated_by: "some updated updated_by"
  }
  @invalid_attrs %{currency: nil, buy_rate: nil, sell_rate: nil, updated_by: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all currencies", %{conn: conn} do
      conn = get(conn, ~p"/api/currencies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create currency" do
    test "renders currency when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/currencies", currency: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/currencies/#{id}")

      assert %{
               "id" => ^id,
               "buy_rate" => "120.5",
               "currency" => "some currency",
               "sell_rate" => "120.5",
               "updated_by" => "some updated_by"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/currencies", currency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update currency" do
    setup [:create_currency]

    test "renders currency when data is valid", %{
      conn: conn,
      currency: %Currency{id: id} = currency
    } do
      conn = put(conn, ~p"/api/currencies/#{currency}", currency: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/currencies/#{id}")

      assert %{
               "id" => ^id,
               "buy_rate" => "456.7",
               "currency" => "some updated currency",
               "sell_rate" => "456.7",
               "updated_by" => "some updated updated_by"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency} do
      conn = put(conn, ~p"/api/currencies/#{currency}", currency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete currency" do
    setup [:create_currency]

    test "deletes chosen currency", %{conn: conn, currency: currency} do
      conn = delete(conn, ~p"/api/currencies/#{currency}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/currencies/#{currency}")
      end
    end
  end

  defp create_currency(_) do
    currency = currency_fixture()
    %{currency: currency}
  end
end
