defmodule CurrencyTraderWeb.AgentControllerTest do
  use CurrencyTraderWeb.ConnCase

  import CurrencyTrader.AgentsFixtures

  alias CurrencyTrader.Agents.Agent

  @create_attrs %{
    name: "some name",
    username: "some username",
    hash_password: "some hash_password"
  }
  @update_attrs %{
    name: "some updated name",
    username: "some updated username",
    hash_password: "some updated hash_password"
  }
  @invalid_attrs %{name: nil, username: nil, hash_password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all agents", %{conn: conn} do
      conn = get(conn, ~p"/api/agents")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create agent" do
    test "renders agent when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/agents", agent: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/agents/#{id}")

      assert %{
               "id" => ^id,
               "hash_password" => "some hash_password",
               "name" => "some name",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/agents", agent: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update agent" do
    setup [:create_agent]

    test "renders agent when data is valid", %{conn: conn, agent: %Agent{id: id} = agent} do
      conn = put(conn, ~p"/api/agents/#{agent}", agent: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/agents/#{id}")

      assert %{
               "id" => ^id,
               "hash_password" => "some updated hash_password",
               "name" => "some updated name",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, agent: agent} do
      conn = put(conn, ~p"/api/agents/#{agent}", agent: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete agent" do
    setup [:create_agent]

    test "deletes chosen agent", %{conn: conn, agent: agent} do
      conn = delete(conn, ~p"/api/agents/#{agent}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/agents/#{agent}")
      end
    end
  end

  defp create_agent(_) do
    agent = agent_fixture()
    %{agent: agent}
  end
end
