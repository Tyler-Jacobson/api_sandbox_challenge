defmodule ApiSandboxChallenge.DataGenerators.AccountDetailGenerators do

  alias ApiSandboxChallenge.DataGenerators.GlobalGenerators
  alias ApiSandboxChallenge.DataGenerators.AccountGenerators

  # generates the details for a specific account
  def generate_account_details(seed, account_id, index) do
    # uses the generate_values function to return an 11 digit account number, and a 9 digit routing number respectively
    account_number = GlobalGenerators.generate_values(seed, 0, index, 10, 11, &GlobalGenerators.list_to_string/1)
    ach = GlobalGenerators.generate_values(seed, account_number.index, index, 10, 9, &GlobalGenerators.list_to_string/1)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    # generates and fills in the details template with relevant data for a specific account
    %ApiSandboxChallenge.Management.AccountDetail{
      account_id: account_id,
      account_number: account_number.return_value,
      links: %{
        account: "#{base_url}/accounts/#{account_id}?username=test_token_#{seed}",
        self: "#{base_url}/accounts/#{account_id}/details?username=test_token_#{seed}"
      },
      routing_numbers: %{
        ach: ach.return_value
      }
    }
  end

  # return account details for a specific account
  def get_account_details(seed, account_id) do
    # gets the account's list index, which is used for further generation
    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))
    generate_account_details(seed, account_id, account_index)
  end

end
