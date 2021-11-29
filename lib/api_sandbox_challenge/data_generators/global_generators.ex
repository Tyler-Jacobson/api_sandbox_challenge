defmodule ApiSandboxChallenge.DataGenerators.GlobalGenerators do

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

end
