defmodule ApiSandboxChallengeWeb.BalanceController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Balance
  alias ApiSandboxChallenge.HelperFunctions

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def show(conn, %{"id" => id, "username" => username}) do
    seed = HelperFunctions.parse_token(username)
    balance = Management.get_balance!(id, seed)
    render(conn, "show.json", balance: balance)
  end
end
