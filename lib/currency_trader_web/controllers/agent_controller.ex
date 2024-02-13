defmodule CurrencyTraderWeb.AgentController do
  use CurrencyTraderWeb, :controller

  alias CurrencyTrader.{Agents, Agents.Agent, Vaults, Vaults.Vault}

  alias CurrencyTraderWeb.{Auth.Guardian ,  Auth.ErrorResponse}

  action_fallback CurrencyTraderWeb.FallbackController

  def index(conn, _params) do
    agents = Agents.list_agents()
    render(conn, :index, agents: agents)
  end

  def create(conn, %{"agent" => agent_params}) do
    with {:ok, %Agent{} = agent} <- Agents.create_agent(agent_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(agent),
         {:ok, %Vault{} = _vault} <- Vaults.create_vault(agent, agent_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/agents/#{agent}")
      |> render(:agent_token, %{agent: agent, token: token})
    end
  end

  def login(conn , %{"username" => username , "hash_password" => hash_password}) do
     response  = Guardian.authenticate(username , hash_password)
    case response do
      {:ok , agent , token} ->
        conn
        |> put_status(:ok)
        |> render(:agent_token , %{agent: agent, token: token})
      {:error , :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Incorrect login credentials"

    end
  end

  def show(conn, %{"id" => id}) do
    agent = Agents.get_agent!(id)
    render(conn, :show, agent: agent)
  end

  def update(conn, %{"id" => id, "agent" => agent_params}) do
    agent = Agents.get_agent!(id)

    with {:ok, %Agent{} = agent} <- Agents.update_agent(agent, agent_params) do
      render(conn, :show, agent: agent)
    end
  end

  def delete(conn, %{"id" => id}) do
    agent = Agents.get_agent!(id)

    with {:ok, %Agent{}} <- Agents.delete_agent(agent) do
      send_resp(conn, :no_content, "")
    end
  end
end
