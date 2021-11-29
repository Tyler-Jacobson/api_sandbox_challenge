defmodule ApiSandboxChallenge.DataGenerators.AccountGenerators do

  alias ApiSandboxChallenge.DataGenerators.GlobalGenerators

  def generate_account_id(seed, account_index) do
    account_id_generated_values = GlobalGenerators.generate_values(seed, 0, account_index, 36, 20, &GlobalGenerators.int_list_to_alphanumeric_string/1)
    _account_id = "acc_#{account_id_generated_values.return_value}"
  end

  # Transfers -> to detail and transactions
  def find_account_index_by_id(seed, account_id, count) do
    count = count - 1
    found_id = generate_account_id(seed, count)

    cond do
      found_id == account_id -> count
      count <= 0 -> "No account with id #{account_id} found"
      true -> find_account_index_by_id(seed, account_id, count)
    end
  end

  def get_currency(index_list) do
    index = Enum.at(index_list, 0)
    currencies = ["USD", "GBP", "EUR", "AUD", "NZD", "SKW"]
    Enum.at(currencies, index)
  end

  def get_instituitons(index_list) do
    index = Enum.at(index_list, 0)
    institutions = ["Chase", "Bank of America", "Wells Fargo", "Citibank", "Capital One"]
    institution_ids = ["chase", "bank_of_america", "wells_fargo", "citibank", "capital_one"]

    institution_name = Enum.at(institutions, index)
    institution_id = Enum.at(institution_ids, index)
    %{institution_id: institution_id, institution_name: institution_name}
  end

  def get_name(index_list) do
    index = Enum.at(index_list, 0)
    names = ["My Checking", "Jimmy Carter", "Ronald Reagan", "George H. W. Bush", "Bill Clinton", "George W. Bush", "Barack Obama", "Donald Trump"]
    Enum.at(names, index)
  end

  def generate_account(seed, account_index) do
    account_id = generate_account_id(seed, account_index)

    currency_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 6, 1, &get_currency/1)
    enrollment_id_generated_values = GlobalGenerators.generate_values(seed, currency_generated_values.index, account_index, 36, 20, &GlobalGenerators.int_list_to_alphanumeric_string/1)
    institution_generated_values = GlobalGenerators.generate_values(seed, enrollment_id_generated_values.index, account_index, 5, 1, &get_instituitons/1)
    last_four_generated_values = GlobalGenerators.generate_values(seed, institution_generated_values.index, account_index, 10, 4, &GlobalGenerators.list_to_string/1)
    name_generated_values = GlobalGenerators.generate_values(seed, last_four_generated_values.index, account_index, 8, 1, &get_name/1)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    %ApiSandboxChallenge.Management.Account{
      currency: currency_generated_values.return_value,
      enrollment_id: "enr_#{enrollment_id_generated_values.return_value}",
      id: account_id,
      institution: %{
        institution_id: "#{institution_generated_values.return_value.institution_id}",
        name: "#{institution_generated_values.return_value.institution_name}"
      },
      last_four: "#{last_four_generated_values.return_value}",
      links: %{
        balances: "#{base_url}/accounts/#{account_id}/balances?username=test_token_#{seed}",
        details: "#{base_url}/accounts/#{account_id}/details?username=test_token_#{seed}",
        self: "#{base_url}/accounts/#{account_id}?username=test_token_#{seed}",
        transactions: "#{base_url}/accounts/#{account_id}/transactions?username=test_token_#{seed}"
      },
      name: "#{name_generated_values.return_value}",
      subtype: "checking",
      type: "depository"
    }
  end

  def generate_accounts(seed, count, accounts_list \\ []) do
    count = count - 1

    account = generate_account(seed, count)
    accounts_list = [account | accounts_list]

    if count <= 0 do
      accounts_list
    else
      generate_accounts(seed, count, accounts_list)
    end
  end



  # return all account data for a given seed
  def all_accounts(seed) do
    generate_accounts(seed, GlobalGenerators.total_accounts(seed))
  end

  # return account information for a specific account
  def get_account(seed, account_id) do
    index = find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))
    generate_account(seed, index)
  end

end
