defmodule ApiSandboxChallenge.DataGenerators.AccountGenerators do

  # GLOBAL GENERATORS START

  def generate_values(seed, local_index, account_index, number_of_possible_outcomes, count_needed, processing_function, transaction_index \\ 0, return_list \\ []) do
    rotating_primes = [53, 73, 89, 101, 109, 139, 151, 227, 47, 113, 149, 157, 163, 5, 23, 29, 79, 257, 197, 181, 191, 89, 97, 43, 37, 61, 211]

    seed_index = rem(local_index, 9)
    prime_index = rem(local_index, Enum.count(rotating_primes))

    prime_index_transaction = rem(transaction_index, Enum.count(rotating_primes))

    transaction_index = transaction_index + prime_index_transaction

    # gets the integer of the seed(converted to a list) at a specific index, adds it to the index, along with several other values, in order to create psuedo randomization
    base_value = (Enum.at(Integer.digits(seed), seed_index) + local_index + (account_index * 13) + (transaction_index * 7)) * Enum.at(rotating_primes, prime_index)

    # the remainder of the above value is taken to create final procedural outputs from the seed
    return_value = rem(base_value, number_of_possible_outcomes)

    # the index is incremented before being passed to the function again recursively, the effect is similar to that of a list index being incremented,
    # but this value can be returned with the return_list, and then passed in the next time this function is run (non-recursively) to ensure that
    # each new run of the function does not produce the same output
    local_index = local_index + 1

    # new value is prepended to the list, I've read that in Elixir prepending is more resource efficient
    return_list = [return_value | return_list]

    # base case to exit recursion. If the number of generated values is equal or greater than the number needed, exit
    if Enum.count(return_list) >= count_needed do
      return_value = processing_function.(return_list)
      %{return_value: return_value, index: local_index}
    else
      generate_values(seed, local_index, account_index, number_of_possible_outcomes, count_needed, processing_function, transaction_index, return_list)
    end
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

  def generated_values_to_float(index_list) do
    string_nums = list_to_string(index_list)
    float_side_one = String.slice(string_nums, 0..-3)
    float_side_two = String.slice(string_nums, 2..-1)
    float_string = "#{float_side_one}.#{float_side_two}"
    _float_string = String.to_float(float_string)
  end

    # 1-4 accounts are generated based on the seed
  def total_accounts(seed) do
    rem((seed + 3), 5)
  end

  # GLOBAL GENERATORS END

  # ACCOUNT GENERATORS START

  def generate_account_id(seed, account_index) do
    account_id_generated_values = generate_values(seed, 0, account_index, 36, 20, &int_list_to_alphanumeric_string/1)
    _account_id = "acc_#{account_id_generated_values.return_value}"
  end

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

    currency_generated_values = generate_values(seed, 20, account_index, 6, 1, &get_currency/1)
    enrollment_id_generated_values = generate_values(seed, currency_generated_values.index, account_index, 36, 20, &int_list_to_alphanumeric_string/1)
    institution_generated_values = generate_values(seed, enrollment_id_generated_values.index, account_index, 5, 1, &get_instituitons/1)
    last_four_generated_values = generate_values(seed, institution_generated_values.index, account_index, 10, 4, &list_to_string/1)
    name_generated_values = generate_values(seed, last_four_generated_values.index, account_index, 8, 1, &get_name/1)

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
    generate_accounts(seed, total_accounts(seed))
  end

  # return account information for a specific account
  def get_account(seed, account_id) do
    index = find_account_index_by_id(seed, account_id, total_accounts(seed))
    generate_account(seed, index)
  end

  # ACCOUNT GENERATORS END

  # ACCOUNT DETAIL GENERATORS START

  def generate_account_details(seed, account_id, index) do
    account_number = generate_values(seed, 0, index, 10, 11, &list_to_string/1)
    ach = generate_values(seed, account_number.index, index, 10, 9, &list_to_string/1)
    base_url = ApiSandboxChallengeWeb.Endpoint.url()

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
    account_index = find_account_index_by_id(seed, account_id, total_accounts(seed))
    generate_account_details(seed, account_id, account_index)
  end

  # ACCOUNT DETAIL GENERATORS END

  # ACCOUNT BALANCE GENERATORS START

  def generate_running_balance(seed, account_id, count \\ 90, running_balance \\ "10000.0") do
    count = count - 1
    transaction_slice = generate_transaction_slice(seed, count, account_id, running_balance)
    running_balance = transaction_slice.running_balance
    if count <= 0 do
      running_balance
    else
      generate_running_balance(seed, account_id, count, running_balance)
    end
  end

  def generate_balance_details(account_id, seed) do
    available = generate_running_balance(seed, account_id)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    %ApiSandboxChallenge.Management.Balance{
      account_id: account_id,
      available: available,
      ledger: "#{String.to_float(available) + 232.32}",
      links: %{
        account: "#{base_url}/accounts/#{account_id}?username=test_token_#{seed}",
        self: "#{base_url}/accounts/#{account_id}/balances?username=test_token_#{seed}"
      }
    }
  end



  # return account balance for a specific account
  def get_balance_details(seed, account_id) do
    generate_balance_details(account_id, seed)
  end

  # ACCOUNT BALANCE GENERATORS END

  # ACCOUNT TRANSACTION GENERATORS START

  def generate_transaction_id(seed, transaction_index, account_index) do
    transaction_id_generated_values = generate_values(seed, 20, account_index, 36, 20, &int_list_to_alphanumeric_string/1, transaction_index)
    _transaction_id = "txn_#{transaction_id_generated_values.return_value}"
  end

  def find_transaction_index_by_id(account_index, transaction_id, seed, count \\ 90) do
    count = count - 1

    found_id = generate_transaction_id(seed, count, account_index)

    cond do
      found_id == transaction_id -> count
      count <= 0 -> "No transaction with id #{transaction_id} found"
      true -> find_transaction_index_by_id(account_index, transaction_id, seed, count)
    end
  end

  def select_merchant(index_list) do
    merchants = [
      ["Uber", "transportation"],
      ["Uber Eats", "dining"],
      ["Lyft", "transportation"],
      ["Five Guys", "dining"],
      ["In-N-Out Burger", "dining"],
      ["Chick-Fil-A", "dining"],
      ["AMC Metreon", "entertainment"],
      ["Apple", "electronics"],
      ["Amazon", "shopping"],
      ["Walmart", "shopping"],
      ["Target", "shopping"],
      ["Hotel Tonight", "accommodation"],
      ["Misson Ceviche", "dining"],
      ["The Creamery", "dining"],
      ["Caltrain", "transportation"],
      ["Wingstop", "dining"],
      ["Slim Chickens", "dining"],
      ["CVS", "health"],
      ["Duane Reade", "health"],
      ["Walgreens", "shopping"],
      ["Rooster & Rice", "dining"],
      ["McDonald's", "dining"],
      ["Burger King", "dining"],
      ["KFC", "dining"],
      ["Popeye's", "dining"],
      ["Shake Shack", "dining"],
      ["Lowe's", "shopping"],
      ["The Home Depot", "shopping"],
      ["Costco", "shopping"],
      ["Kroger", "shopping"],
      ["iTunes", "software"],
      ["Spotify", "entertainment"],
      ["Best Buy", "electronics"],
      ["TJ Maxx", "clothing"],
      ["Aldi", "shopping"],
      ["Dollar General", "shopping"],
      ["Macy's", "clothing"],
      ["H.E. Butt", "groceries"],
      ["Dollar Tree", "shopping"],
      ["Verizon Wireless", "phone"],
      ["Sprint PCS", "phone"],
      ["T-Mobile", "phone"],
      ["Kohl's", "clothing"],
      ["Starbucks", "service"],
      ["7-Eleven", "fuel"],
      ["AT&T Wireless", "phone"],
      ["Rite Aid", "health"],
      ["Nordstrom", "clothing"],
      ["Ross", "clothing"],
      ["Gap", "clothing"],
      ["Bed, Bath & Beyond", "home"],
      ["J.C. Penney", "clothing"],
      ["Subway", "dining"],
      ["O'Reilly", "transport"],
      ["Wendy's", "dining"],
      ["Dunkin' Donuts", "dining"],
      ["Petsmart", "home"],
      ["Dick's Sporting Goods", "shopping"],
      ["Sears", "clothing"],
      ["Staples", "office"],
      ["Domino's Pizza", "dining"],
      ["Pizza Hut", "dining"],
      ["Papa John's", "dining"],
      ["IKEA", "home"],
      ["Office Depot", "office"],
      ["Foot Locker", "clothing"],
      ["Lids", "clothing"],
      ["GameStop", "entertainment"],
      ["Sephora", "shopping"],
      ["MAC", "shopping"],
      ["Panera", "dining"],
      ["Williams-Sonoma", "home"],
      ["Saks Fifth Avenue", "clothing"],
      ["Chipotle Mexican Grill", "dining"],
      ["Exxon Mobil", "fuel"],
      ["Neiman Marcus", "clothing"],
      ["Jack In The Box", "dining"],
      ["Sonic", "dining"],
      ["Shell", "fuel"]
    ]
    selected_index = Enum.at(index_list, 0)
    Enum.at(merchants, selected_index)
  end


  def generate_transaction(seed, transaction_index, account_id, running_balance) do

    account_index = find_account_index_by_id(seed, account_id, total_accounts(seed))

    transaction_id = generate_transaction_id(seed, transaction_index, account_index)

    amount_generated_values = generate_values(seed, 20, account_index, 9, 4, &generated_values_to_float/1, transaction_index)

    amount = amount_generated_values.return_value
    running_balance = String.to_float(running_balance) - amount
    running_balance = running_balance |> Float.ceil(2)

    selected_merchant = generate_values(seed, amount_generated_values.index, transaction_index, 79, 1, &select_merchant/1, transaction_index)

    date = DateTime.add(DateTime.utc_now(), -86400 * transaction_index, :second)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    %ApiSandboxChallenge.Management.Transaction{
      account_id: account_id,
      amount: "#{amount}",
      date: "#{date}",
      description: "#{Enum.at(selected_merchant.return_value, 0)}",
      details: %{
        category: "#{Enum.at(selected_merchant.return_value, 1)}",
        counterparty: %{
          name: "#{Enum.at(selected_merchant.return_value, 0)}",
          type: "organization"
        },
        processing_status: "complete"
      },
      transaction_id: transaction_id,
      links: %{
        account: "#{base_url}/accounts/#{account_id}?username=test_token_#{seed}",
        self: "#{base_url}/accounts/#{account_id}/transactions/#{transaction_id}?username=test_token_#{seed}"
      },
      running_balance: "#{running_balance}",
      status: "posted",
      type: "ach"
    }
  end

  def generate_transactions(seed, account_id, count \\ 90, running_balance \\ "10000.0", transactions_list \\ []) do
    count = count - 1

    transaction = generate_transaction(seed, count, account_id, running_balance)
    transactions_list = [transaction | transactions_list]

    running_balance = transaction.running_balance

    if count <= 0 do
      transactions_list
    else
      generate_transactions(seed, account_id, count, running_balance, transactions_list)
    end
  end

  def generate_transaction_slice(seed, transaction_index, account_id, running_balance) do

    account_index = find_account_index_by_id(seed, account_id, total_accounts(seed))

    transaction_id = generate_transaction_id(seed, transaction_index, account_index)

    amount_generated_values = generate_values(seed, 20, account_index, 9, 4, &generated_values_to_float/1, transaction_index)

    amount = amount_generated_values.return_value

    running_balance = String.to_float(running_balance) - amount
    running_balance = running_balance |> Float.ceil(2)

    %{
      transaction_id: transaction_id,
      running_balance: "#{running_balance}",
      amount: amount
    }
  end

  def generate_running_balance_by_transaction_id(seed, desired_transaction_id, account_id, count \\ 90, running_balance \\ "10000.0") do
    count = count - 1

    transaction_slice = generate_transaction_slice(seed, count, account_id, running_balance)

    running_balance = transaction_slice.running_balance

    if desired_transaction_id == transaction_slice.transaction_id do
      "#{String.to_float(running_balance) + transaction_slice.amount}"
    else
      generate_running_balance_by_transaction_id(seed, desired_transaction_id, account_id, count, running_balance)
    end
  end



  # return all transactions for a specific account
  def all_transactions(seed, account_id) do
    generate_transactions(seed, account_id)
  end

  # return a specific transaction for a specific account
  def get_transaction(seed, account_id, transaction_id) do
    running_balance = generate_running_balance_by_transaction_id(seed, transaction_id, account_id)
    account_index = find_account_index_by_id(seed, account_id, total_accounts(seed))
    transaction_index = find_transaction_index_by_id(account_index, transaction_id, seed)

    generate_transaction(seed, transaction_index, account_id, running_balance)
  end

  # ACCOUNT TRANSACTION GENERATORS END
end
