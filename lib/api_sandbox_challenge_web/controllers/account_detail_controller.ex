defmodule ApiSandboxChallengeWeb.AccountDetailController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.AccountDetail

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, _params) do
    account_details = Management.list_account_details()
    render(conn, "index.json", account_details: account_details)
  end

  def create(conn, %{"account_detail" => account_detail_params}) do
    with {:ok, %AccountDetail{} = account_detail} <- Management.create_account_detail(account_detail_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_detail_path(conn, :show, account_detail))
      |> render("show.json", account_detail: account_detail)
    end
  end

  def show(conn, %{"id" => id}) do
    account_detail = Management.get_account_detail!(id)
    render(conn, "show.json", account_detail: account_detail)
  end

  def update(conn, %{"id" => id, "account_detail" => account_detail_params}) do
    account_detail = Management.get_account_detail!(id)

    with {:ok, %AccountDetail{} = account_detail} <- Management.update_account_detail(account_detail, account_detail_params) do
      render(conn, "show.json", account_detail: account_detail)
    end
  end

  def delete(conn, %{"id" => id}) do
    account_detail = Management.get_account_detail!(id)

    with {:ok, %AccountDetail{}} <- Management.delete_account_detail(account_detail) do
      send_resp(conn, :no_content, "")
    end
  end
end
