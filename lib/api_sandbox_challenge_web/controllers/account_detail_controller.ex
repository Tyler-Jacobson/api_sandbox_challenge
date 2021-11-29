defmodule ApiSandboxChallengeWeb.AccountDetailController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.AccountDetail

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def show(conn, %{"id" => id, "username" => username}) do
    seed = Management.parse_token(username)
    account_detail = Management.get_account_detail!(id, seed)
    render(conn, "show.json", account_detail: account_detail)
  end
end
