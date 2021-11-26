defmodule ApiSandboxChallengeWeb.BalanceController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Balance

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, _params) do
    balances = Management.list_balances()
    render(conn, "index.json", balances: balances)
  end

  def create(conn, %{"balance" => balance_params}) do
    with {:ok, %Balance{} = balance} <- Management.create_balance(balance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.balance_path(conn, :show, balance))
      |> render("show.json", balance: balance)
    end
  end

  def show(conn, %{"id" => id}) do
    balance = Management.get_balance!(id)
    render(conn, "show.json", balance: balance)
  end

  def update(conn, %{"id" => id, "balance" => balance_params}) do
    balance = Management.get_balance!(id)

    with {:ok, %Balance{} = balance} <- Management.update_balance(balance, balance_params) do
      render(conn, "show.json", balance: balance)
    end
  end

  def delete(conn, %{"id" => id}) do
    balance = Management.get_balance!(id)

    with {:ok, %Balance{}} <- Management.delete_balance(balance) do
      send_resp(conn, :no_content, "")
    end
  end
end
