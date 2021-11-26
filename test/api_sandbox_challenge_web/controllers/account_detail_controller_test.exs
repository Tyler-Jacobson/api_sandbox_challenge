defmodule ApiSandboxChallengeWeb.AccountDetailControllerTest do
  use ApiSandboxChallengeWeb.ConnCase

  import ApiSandboxChallenge.ManagementFixtures

  alias ApiSandboxChallenge.Management.AccountDetail

  @create_attrs %{
    account_id: "some account_id",
    account_number: "some account_number",
    links: %{},
    routing_numbers: %{}
  }
  @update_attrs %{
    account_id: "some updated account_id",
    account_number: "some updated account_number",
    links: %{},
    routing_numbers: %{}
  }
  @invalid_attrs %{account_id: nil, account_number: nil, links: nil, routing_numbers: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all account_details", %{conn: conn} do
      conn = get(conn, Routes.account_detail_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account_detail" do
    test "renders account_detail when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_detail_path(conn, :create), account_detail: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.account_detail_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "account_id" => "some account_id",
               "account_number" => "some account_number",
               "links" => %{},
               "routing_numbers" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_detail_path(conn, :create), account_detail: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account_detail" do
    setup [:create_account_detail]

    test "renders account_detail when data is valid", %{conn: conn, account_detail: %AccountDetail{id: id} = account_detail} do
      conn = put(conn, Routes.account_detail_path(conn, :update, account_detail), account_detail: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.account_detail_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "account_id" => "some updated account_id",
               "account_number" => "some updated account_number",
               "links" => %{},
               "routing_numbers" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account_detail: account_detail} do
      conn = put(conn, Routes.account_detail_path(conn, :update, account_detail), account_detail: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account_detail" do
    setup [:create_account_detail]

    test "deletes chosen account_detail", %{conn: conn, account_detail: account_detail} do
      conn = delete(conn, Routes.account_detail_path(conn, :delete, account_detail))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.account_detail_path(conn, :show, account_detail))
      end
    end
  end

  defp create_account_detail(_) do
    account_detail = account_detail_fixture()
    %{account_detail: account_detail}
  end
end
