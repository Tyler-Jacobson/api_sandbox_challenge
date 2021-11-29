defmodule ApiSandboxChallengeWeb.AccountController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Account
  alias ApiSandboxChallenge.HelperFunctions

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, params) do
      seed = HelperFunctions.parse_token(params["username"])
      accounts = Management.list_accounts(seed)
      render(conn, "index.json", accounts: accounts)
  end

  def show(conn, %{"id" => id, "username" => username}) do
    seed = HelperFunctions.parse_token(username)
    account = Management.get_account!(id, seed)
    render(conn, "show.json", account: account)
  end
end
