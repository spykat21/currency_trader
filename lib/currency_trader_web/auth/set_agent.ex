defmodule CurrencyTraderWeb.Auth.SetAgent do
  import Plug.Conn
  alias CurrencyTraderWeb.Auth.ErrorResponse
  alias CurrencyTrader.Agents

  def init(_options) do
  end

  def call(conn, _options) do
    if conn.assigns[:agent] do
      conn
    else
      agent_id = get_session(conn, :agent_id)
      if agent_id == nil, do: raise(ErrorResponse.Unauthorized)
      agent = Agents.get_agent!(agent_id)

      cond do
        agent_id && agent -> assign(conn, :agent, agent)
        true -> assign(conn, :agent, nil)
      end
    end
  end
end
