defmodule ApiSandboxChallengeWeb.TransactionControllerTest do
  use ApiSandboxChallengeWeb.ConnCase

  import ApiSandboxChallenge.ManagementFixtures

  alias ApiSandboxChallenge.Management.Transaction

  @create_attrs %{
    account_id: "some account_id",
    amount: "some amount",
    date: "some date",
    description: "some description",
    details: %{},
    id: "some id",
    links: %{},
    running_balance: "some running_balance",
    status: "some status",
    type: "some type"
  }
  @update_attrs %{
    account_id: "some updated account_id",
    amount: "some updated amount",
    date: "some updated date",
    description: "some updated description",
    details: %{},
    id: "some updated id",
    links: %{},
    running_balance: "some updated running_balance",
    status: "some updated status",
    type: "some updated type"
  }
  @invalid_attrs %{account_id: nil, amount: nil, date: nil, description: nil, details: nil, id: nil, links: nil, running_balance: nil, status: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, Routes.transaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "account_id" => "some account_id",
               "amount" => "some amount",
               "date" => "some date",
               "description" => "some description",
               "details" => %{},
               "id" => "some id",
               "links" => %{},
               "running_balance" => "some running_balance",
               "status" => "some status",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{conn: conn, transaction: %Transaction{id: id} = transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.transaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "account_id" => "some updated account_id",
               "amount" => "some updated amount",
               "date" => "some updated date",
               "description" => "some updated description",
               "details" => %{},
               "id" => "some updated id",
               "links" => %{},
               "running_balance" => "some updated running_balance",
               "status" => "some updated status",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, Routes.transaction_path(conn, :update, transaction), transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, Routes.transaction_path(conn, :delete, transaction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.transaction_path(conn, :show, transaction))
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
