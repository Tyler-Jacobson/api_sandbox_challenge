defmodule ApiSandboxChallengeWeb.PageController do
  use ApiSandboxChallengeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
