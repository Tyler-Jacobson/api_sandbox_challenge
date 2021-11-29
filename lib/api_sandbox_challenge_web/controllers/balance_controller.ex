defmodule ApiSandboxChallengeWeb.BalanceController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Balance

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def show(conn, %{"id" => id}) do
    balance = Management.get_balance!(id)
    render(conn, "show.json", balance: balance)
  end
end
