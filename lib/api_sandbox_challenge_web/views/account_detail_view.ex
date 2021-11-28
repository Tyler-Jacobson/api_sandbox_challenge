defmodule ApiSandboxChallengeWeb.AccountDetailView do
  use ApiSandboxChallengeWeb, :view
  alias ApiSandboxChallengeWeb.AccountDetailView

  def render("index.json", %{account_details: account_details}) do
    %{data: render_many(account_details, AccountDetailView, "account_detail.json")}
  end

  def render("show.json", %{account_detail: account_detail}) do
    %{data: render_one(account_detail, AccountDetailView, "account_detail.json")}
  end

  def render("account_detail.json", %{account_detail: account_detail}) do
    %{
      account_id: account_detail.account_id,
      account_number: account_detail.account_number,
      links: account_detail.links,
      routing_numbers: account_detail.routing_numbers
    }
  end
end
