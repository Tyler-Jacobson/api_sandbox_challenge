defmodule ApiSandboxChallengeWeb.AccountDetailController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.AccountDetail
  alias ApiSandboxChallenge.HelperFunctions

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def show(conn, %{"id" => account_id, "username" => username}) do
    seed = HelperFunctions.parse_token(username)
    account_detail = Management.get_account_detail!(account_id, seed)
    render(conn, "show.json", account_detail: account_detail)
  end
end
