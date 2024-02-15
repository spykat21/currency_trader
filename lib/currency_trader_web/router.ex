defmodule CurrencyTraderWeb.Router do
  use CurrencyTraderWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    IO.inspect(message)

    conn
    |> json(%{errors: message})
    |> halt()
  end

  defp handle_errors(conn, %{kind: _, reason: _} = error) do
    # Log the error or perform any necessary actions
    IO.inspect(error.reason)

    # Return an appropriate response
    conn
    |> json(%{errors: "Unexpected error occurred"})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug CurrencyTraderWeb.Auth.Pipeline
  end

  scope "/api", CurrencyTraderWeb do
    pipe_through :api

    post "/agent/", AgentController, :create
    post "/agent/login/", AgentController, :login
  end

  scope "/api/", CurrencyTraderWeb do
    pipe_through [:api, :auth]

    get "/agent/:id", AgentController, :show
    get "/agent/", AgentController, :index
    post "/vault/", VaultController, :create
    get "/vault/:agent_id/", VaultController, :get_vault
    post "/currency/", CurrencyController, :create
    get "/currency/", CurrencyController, :index
    post "/transaction/", TransactionController, :create
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:currency_trader, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CurrencyTraderWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
