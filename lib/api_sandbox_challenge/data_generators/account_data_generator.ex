defmodule ApiSandboxChallenge.DataGenerators.AccountDataGenerator do


  def generate_values(seed, index, parent_index, number_of_possible_outcomes, count_needed, return_list \\ []) do
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
      %{return_list: return_list, index: index}
    else
      generate_values(seed, new_index, parent_index, number_of_possible_outcomes, count_needed, return_list)
    end
  end

  def get_currencies(index) do
    currencies = ["USD", "GBP", "EUR", "AUD", "NZD", "SKW"]
    Enum.at(currencies, index)
  end

  def int_list_to_alphanumeric_string(numbers_list, index \\ 0, return_string \\ "") do
    characters_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    number_index = Enum.at(numbers_list, index)
    IO.inspect "THIS IS number_index #{numbers_list}"
    character = Enum.at(characters_list, number_index)


    return_string = return_string <> character

    index = index + 1
    if index >= Enum.count(numbers_list) do
      return_string
    else
      int_list_to_alphanumeric_string(numbers_list, index, return_string)
    end
  end





  # return all account data for a given seed
  def all_accounts do
    [
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmf3f7758gpc7b5cd6000",
        id: "acc_nmfff743stmo5n80t4000",
        institution: %{
          institution_id: "citibank",
          name: "Citibank"
        },
        last_four: "3836",
        links: %{
          balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
          details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
          self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "My Checking",
        subtype: "checking",
        type: "depository"
      },
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmftg43ewubftwy7z2000",
        id: "acc_nmfrhsafs84fhzwz7000",
        institution: %{
          institution_id: "citibank",
          name: "Citibank"
        },
        last_four: "3836",
        links: %{
          balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
          details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
          self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "Timmy's Checking",
        subtype: "checking",
        type: "depository"
      },
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmfuf7ews34fdsfz1000",
        id: "acc_nmfuksefybsujey3000",
        institution: %{
          institution_id: "citibank",
          name: "Citibank"
        },
        last_four: "3836",
        links: %{
          balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
          details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
          self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "Jimmy Carter",
        subtype: "checking",
        type: "depository"
      }
    ]


  end

  def get_account(id) do

    # 873462546
    # 392857372
    seed = 392857372

    currency_generated_values = generate_values(seed, 0, 1, 6, 1)
    selected_currency_index = Enum.at(currency_generated_values.return_list, 0)
    chosen_currency = get_currencies(selected_currency_index)

    enrollment_id_generated_values = generate_values(seed, currency_generated_values.index, 1, 36, 20)
    enrollment_id_string = int_list_to_alphanumeric_string(enrollment_id_generated_values.return_list)

    # item_zero = Enum.at(enrollment_id_string, 0)



    %ApiSandboxChallenge.Management.Account{
      currency: chosen_currency,
      enrollment_id: "enr_#{enrollment_id_string}",
      id: "acc_nmfuksefybsujey3000",
      institution: %{
        institution_id: "citibank",
        name: "Citibank"
      },
      last_four: "3836",
      links: %{
        balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
        details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
      },
      name: "Timmy",
      subtype: "checking",
      type: "depository"
    }
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
