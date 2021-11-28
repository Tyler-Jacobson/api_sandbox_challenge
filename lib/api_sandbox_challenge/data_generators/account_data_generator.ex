defmodule ApiSandboxChallenge.DataGenerators.AccountDataGenerator do


  def generate_values(seed, index, parent_index, number_of_possible_outcomes, count_needed, processing_function, return_list \\ []) do
    rotating_primes = [53, 73, 89, 101, 109, 139, 151, 227, 47, 113, 149, 157, 163]

    seed_index = rem(index, 9)
    prime_index = rem(index, 13)

    # gets the integer of the seed(converted to a list) at a specific index, adds it to the index, along with the (parent_index * 13),
    # it then multiplies that output by the selected number from the rotating_primes list
    base_value = (Enum.at(Integer.digits(seed), seed_index) + index + (parent_index * 13)) * Enum.at(rotating_primes, prime_index)

    # the remainder of the above value is taken to create final procedural outputs from the seed
    return_value = rem(base_value, number_of_possible_outcomes)

    # the index is incremented before being passed to the function again recursively, the effect is similar to that of a list index being incremented,
    # but this value can be returned with the return_list, and then passed in the next time this function is run (non-recursively) to ensure that
    # each new run of the function does not produce the same output
    new_index = index + 1

    # new value is prepended to the list, I've read that in Elixir prepending is more resource efficient
    return_list = [return_value | return_list]


    # base case to exit recursion. If the number of generated values is equal or greater than the number needed, exit
    if Enum.count(return_list) >= count_needed do
      return_value = processing_function.(return_list)
      %{return_value: return_value, index: index}
    else
      generate_values(seed, new_index, parent_index, number_of_possible_outcomes, count_needed, processing_function, return_list)
    end
  end

  def get_currency(index_list) do
    index = Enum.at(index_list, 0)
    currencies = ["USD", "GBP", "EUR", "AUD", "NZD", "SKW"]
    Enum.at(currencies, index)
  end

  def int_list_to_alphanumeric_string(numbers_list, index \\ 0, return_string \\ "") do
    characters_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    number_index = Enum.at(numbers_list, index)
    character = Enum.at(characters_list, number_index)


    return_string = return_string <> character

    index = index + 1
    if index >= Enum.count(numbers_list) do
      return_string
    else
      int_list_to_alphanumeric_string(numbers_list, index, return_string)
    end
  end



  def get_instituitons(index_list) do
    index = Enum.at(index_list, 0)
    institutions = ["Chase", "Bank of America", "Wells Fargo", "Citibank", "Capital One"]
    institution_ids = ["chase", "bank_of_america", "wells_fargo", "citibank", "capital_one"]

    institution_name = Enum.at(institutions, index)
    institution_id = Enum.at(institution_ids, index)
    %{institution_id: institution_id, institution_name: institution_name}
  end

  def list_to_string(numbers_list, index \\ 0, string \\ "") do
    character = Enum.at(numbers_list, index)

    string = string <> "#{character}"

    index = index + 1
    if index >= Enum.count(numbers_list) do
      string
    else
      list_to_string(numbers_list, index, string)
    end
  end

  def get_name(index_list) do
    index = Enum.at(index_list, 0)
    names = ["My Checking", "Jimmy Carter", "Ronald Reagan", "George H. W. Bush", "Bill Clinton", "George W. Bush", "Barack Obama", "Donald Trump"]
    Enum.at(names, index)
  end



  def generate_id(seed, parent_index) do
    account_id_generated_values = generate_values(seed, 0, parent_index, 36, 20, &int_list_to_alphanumeric_string/1)
    _account_id = "acc_#{account_id_generated_values.return_value}"
  end

  def generate_account(seed, parent_index) do
    account_id = generate_id(seed, parent_index)

    currency_generated_values = generate_values(seed, 20, parent_index, 6, 1, &get_currency/1)
    enrollment_id_generated_values = generate_values(seed, currency_generated_values.index, parent_index, 36, 20, &int_list_to_alphanumeric_string/1)
    institution_generated_values = generate_values(seed, enrollment_id_generated_values.index, parent_index, 5, 1, &get_instituitons/1)
    last_four_generated_values = generate_values(seed, institution_generated_values.index, parent_index, 10, 4, &list_to_string/1)
    name_generated_values = generate_values(seed, last_four_generated_values.index, 1, 8, parent_index, &get_name/1)

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
        balances: "#{base_url}/accounts/#{account_id}/balances",
        details: "#{base_url}/accounts/#{account_id}/details",
        self: "#{base_url}/accounts/#{account_id}",
        transactions: "#{base_url}/accounts/#{account_id}/transactions"
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

  def find_index_by_id(index) do
    index
  end

  def find_index_by_id(seed, id, count) do
    count = count - 1

    found_id = generate_id(seed, count)

    cond do
      found_id == id -> count
      count <= 0 -> "No account with id #{id} found"
      true -> find_index_by_id(seed, id, count)
    end
  end


  # return all account data for a given seed
  def all_accounts(seed) do
    number_of_accounts_to_generate = rem((seed + 3), 5)

    generate_accounts(seed, 4)
  end

  def get_account(id, seed) do
    index = find_index_by_id(seed, id, 4)
    generate_account(seed, index)
  end

  def get_account_details(id) do
    %ApiSandboxChallenge.Management.AccountDetail{
      account_id: "acc_nmfff743stmo5n80t4000",
      account_number: "891824333836",
      links: %{
        account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details"
      },
      routing_numbers: %{
        ach: "581559698"
      }
    }
  end

  def get_balance_details(id) do
    %ApiSandboxChallenge.Management.Balance{
      account_id: "acc_nmfff743stmo5n80t4000",
      available: "33648.09",
      ledger: "33803.48",
      links: %{
        account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances"
      }
    }
  end

  def all_transactions(id) do
    [
      %ApiSandboxChallenge.Management.Transaction{
        account_id: "acc_nmfff743stmo5n80t4000",
        amount: "90.54",
        date: "2021-08-12",
        description: "In-N-Out Burger",
        details: %{
          category: "dining",
          counterparty: %{
            name: "IN N OUT BURGER",
            type: "organization"
          },
          processing_status: "complete"
        },
        transaction_id: "txn_nmfo2gtnstmo5n80t4004",
        links: %{
          account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          self:
            "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions/txn_nmfo2gtnstmo5n80t4004"
        },
        running_balance: "33648.09",
        status: "posted",
        type: "ach"
      },
      %ApiSandboxChallenge.Management.Transaction{
        account_id: "acc_nmfff743stmo5n80t4000",
        amount: "50.50",
        date: "2021-08-11",
        description: "Uber",
        details: %{
          category: "dining",
          counterparty: %{
            name: "Uber",
            type: "organization"
          },
          processing_status: "complete"
        },
        transaction_id: "txn_nmfo2gtnstmo5n80t4004",
        links: %{
          account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          self:
            "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions/txn_nmfo2gtnstmo5n80t4004"
        },
        running_balance: "33648.09",
        status: "posted",
        type: "ach"
      }
    ]
  end

  def get_transaction(id, transaction_id) do
    %ApiSandboxChallenge.Management.Transaction{
      account_id: "acc_nmfff743stmo5n80t4000",
      amount: "50.50",
      date: "2021-08-11",
      description: "Uber",
      details: %{
        category: "dining",
        counterparty: %{
          name: "Uber",
          type: "organization"
        },
        processing_status: "complete"
      },
      transaction_id: "txn_nmfo2gtnstmo5n80t4004",
      links: %{
        account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        self:
          "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions/txn_nmfo2gtnstmo5n80t4004"
      },
      running_balance: "33648.09",
      status: "posted",
      type: "ach"
    }
  end

end
