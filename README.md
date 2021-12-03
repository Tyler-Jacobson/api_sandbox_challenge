# ApiSandboxChallenge

## Setup
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000/accounts/?username=test_token_347264212) from your browser

## Url Structure

Url Structure is (base/) (endpoint/) (token)

(http://localhost:4000/) (accounts/) (?username=test_token_732645231)

The token value can be any 9 digit integer that does not start with 0

It should be possible to navigate the app using the returned links from each endpoint

## Urls for example token 732645231

All accounts:
http://localhost:4000/accounts/?username=test_token_732645231

Single account:
http://localhost:4000/accounts/acc_98ligqgnowb0bd3v0brq?username=test_token_732645231

Single account details:
http://localhost:4000/accounts/acc_98ligqgnowb0bd3v0brq/details?username=test_token_732645231

Single account balance:
http://localhost:4000/accounts/acc_98ligqgnowb0bd3v0brq/balances?username=test_token_732645231

All transactions from an account
http://localhost:4000/accounts/acc_98ligqgnowb0bd3v0brq/transactions?username=test_token_732645231

Single transaction from a single account
http://localhost:4000/accounts/acc_98ligqgnowb0bd3v0brq/transactions/txn_7sua7j0g9534xl8kt5mj?username=test_token_732645231

The number of accounts generated is procedural, and on a range of 1-4

Here are some additional token values for you to test with, altough any 9 digit number will work

http://localhost:4000/accounts/?username=test_token_321909729

http://localhost:4000/accounts/?username=test_token_206259766

http://localhost:4000/accounts/?username=test_token_111111111


## Technical

A lot of the work for this project was spent on building and refining a procedural generator that was capable of returning consistent yet highly varied results, all while generating unique data across a long list of identical objects (mainly the transactions list).

Said generator recieves a function as an argument, which is then used to process the generated values into final states before being added to the json object for output

All of the code for these data generators and parsers can be found in lib/api_sandbox_challenge/data_generators/, and the central generator function can be found at lib/api_sandbox_challenge/data_generators/global_generators generate_values/8

In addition to the above, changes were naturally made to the data flow through router -> controllers -> views / context(named 'Management')

## Notes

I started learning Elixir just over a week ago. I think what you guys are doing is super cool, and I really want to work with you. Try go easy on me :)








