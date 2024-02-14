defmodule CurrencyTraderWeb.AgentJSON do
  alias CurrencyTrader.Agents.Agent
  alias CurrencyTraderWeb.VaultJSON

  @doc """
  Renders a list of agents.
  """
  def index(%{agents: agents}) do
    %{data: for(agent <- agents, do: data(agent))}
  end

  @doc """
  Renders a single agent.
  """
  def show(%{agent: agent}) do
    %{data: data(agent)}
  end

  def agent_token(%{agent: agent, token: token}) do
    %{
      id: agent.id,
      username: agent.username,
      token: token
    }
  end

  defp data(%Agent{} = agent) do
    %{
      id: agent.id,
      name: agent.name,
      username: agent.username,
      hash_password: agent.hash_password,
      vaults: for(vault <- agent.vaults, do: VaultJSON.data(vault))

    }
  end
end
