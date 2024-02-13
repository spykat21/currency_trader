defmodule CurrencyTraderWeb.VaultControllerTest do
  use CurrencyTraderWeb.ConnCase

  import CurrencyTrader.VaultsFixtures

  alias CurrencyTrader.Vaults.Vault

  @create_attrs %{
    amount: "120.5"
  }
  @update_attrs %{
    amount: "456.7"
  }
  @invalid_attrs %{amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vaults", %{conn: conn} do
      conn = get(conn, ~p"/api/vaults")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vault" do
    test "renders vault when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/vaults", vault: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/vaults/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/vaults", vault: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vault" do
    setup [:create_vault]

    test "renders vault when data is valid", %{conn: conn, vault: %Vault{id: id} = vault} do
      conn = put(conn, ~p"/api/vaults/#{vault}", vault: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/vaults/#{id}")

      assert %{
               "id" => ^id,
               "amount" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, vault: vault} do
      conn = put(conn, ~p"/api/vaults/#{vault}", vault: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vault" do
    setup [:create_vault]

    test "deletes chosen vault", %{conn: conn, vault: vault} do
      conn = delete(conn, ~p"/api/vaults/#{vault}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/vaults/#{vault}")
      end
    end
  end

  defp create_vault(_) do
    vault = vault_fixture()
    %{vault: vault}
  end
end
