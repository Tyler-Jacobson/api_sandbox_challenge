defmodule ApiSandboxChallengeWeb.AccountController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Account

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, params) do
    if params["username"] == nil do
      accounts = []
      render(conn, "index.json", accounts: accounts)
    else
      seed = Management.parse_token(params["username"])
      accounts = Management.list_accounts(seed)
      render(conn, "index.json", accounts: accounts)
    end
  end

  def show(conn, %{"id" => id, "username" => username}) do
    seed = Management.parse_token(username)
    account = Management.get_account!(id, seed)
    render(conn, "show.json", account: account)
  end
end
