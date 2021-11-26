defmodule ApiSandboxChallengeWeb.BalanceControllerTest do
  use ApiSandboxChallengeWeb.ConnCase

  import ApiSandboxChallenge.ManagementFixtures

  alias ApiSandboxChallenge.Management.Balance

  @create_attrs %{
    account_id: "some account_id",
    available: "some available",
    ledger: "some ledger",
    links: %{}
  }
  @update_attrs %{
    account_id: "some updated account_id",
    available: "some updated available",
    ledger: "some updated ledger",
    links: %{}
  }
  @invalid_attrs %{account_id: nil, available: nil, ledger: nil, links: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all balances", %{conn: conn} do
      conn = get(conn, Routes.balance_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create balance" do
    test "renders balance when data is valid", %{conn: conn} do
      conn = post(conn, Routes.balance_path(conn, :create), balance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.balance_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "account_id" => "some account_id",
               "available" => "some available",
               "ledger" => "some ledger",
               "links" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.balance_path(conn, :create), balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update balance" do
    setup [:create_balance]

    test "renders balance when data is valid", %{conn: conn, balance: %Balance{id: id} = balance} do
      conn = put(conn, Routes.balance_path(conn, :update, balance), balance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.balance_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "account_id" => "some updated account_id",
               "available" => "some updated available",
               "ledger" => "some updated ledger",
               "links" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, balance: balance} do
      conn = put(conn, Routes.balance_path(conn, :update, balance), balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete balance" do
    setup [:create_balance]

    test "deletes chosen balance", %{conn: conn, balance: balance} do
      conn = delete(conn, Routes.balance_path(conn, :delete, balance))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.balance_path(conn, :show, balance))
      end
    end
  end

  defp create_balance(_) do
    balance = balance_fixture()
    %{balance: balance}
  end
end
