defmodule CurrencyTraderWeb.Auth.Guardian do
  use Guardian, otp_app: :currency_trader
  alias CurrencyTrader.Agents

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Agents.get_agent!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(username, password) do
    case Agents.get_agent_by_username!(username) do
      nil ->
        {:error, :unauthorized}

      agent ->
        case validate_password(password, agent.hash_password) do
          true -> create_token(agent)
          false -> {:error, :unauthorized}
        end
    end
  end

  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(agent) do
    {:ok, token, _claims} = encode_and_sign(agent)
    {:ok, agent, token}
  end
end
