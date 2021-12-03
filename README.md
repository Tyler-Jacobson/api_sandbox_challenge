# ApiSandboxChallenge

## Setup
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/accounts/?username=test_token_732645231`](http://localhost:4000/accounts/?username=test_token_732645231) from your browser

## Url Structure

Url Structure is (baseurl) / (endpoint) / (token)

(localhost:4000) / (accounts) / (?username=test_token_732645231)

The token value can be any 9 digit integer that does not start with 0

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


## Additional Tokens

The number of accounts generated is procedural, and on a range of 1-4

Here are some additional tokens for you to test with, although any 9 digit number will function as a token value

http://localhost:4000/accounts/?username=test_token_321909729

http://localhost:4000/accounts/?username=test_token_206259766

http://localhost:4000/accounts/?username=test_token_111111111


## Technical

A lot of the work for this project was spent on building and refining a procedural generator that was capable of returning consistent yet varied results, all while generating unique data across a long list of identical objects (mainly the transactions list).

Said generator receives a function as an argument, which is then used to process the generated values into final states before being added to the json object for output

All of the code for these data generators and parsers can be found in ```lib/api_sandbox_challenge/data_generators/```. The central generator function, which powers everything else can be found at ```lib/api_sandbox_challenge/data_generators/global_generators generate_values/8```

In addition to the above, changes were naturally made to the data flow through ```router -> controllers -> views / context```(context is named 'Management')

## Notes

I know that I may not be the top performer in terms of actual project results. I hope the fact that I started learning Elixir just over a week ago, and have been simultaneously learning the language, the Phoenix framework, and completing the specific requirements of the challenge; along with the fact that I was able to come this far, this quickly will go to my credit. I really put 100% effort into this. Not just the project, but trying to get a proper understanding of the language and framework as well. It's something I am genuinely interested in, and plan to continue pursuing. I'm very interested in what you guys are doing, and I really do want to join your team. 

The app is currently working, with all endpoints fully functional, but without authentication or tests. Tim and I agreed that at this point, I had already put a good deal more time than intended into the project in order to learn the fundamentals of the language and framework, and that the current state should hopefully be sufficient to determine if I am a good fit for the company.

I've learned a ton from doing this, and I hope that I can go on to learn a lot from you guys in the future.

## Given more time

There are four major areas I would focus on provided I had more time to commit to this project. 
 - HTTP Basic Auth - Ideally the API would be generating tokens itself and sending them to the users, then authenticating against sent tokens.
 - Testing - Full suite of tests is of course very important, especially to prevent regression and unforeseen bugs.
 - Better Error Handling - Malformed requests currently send the user to a crash screen, which is not ideal for UX or security reasons. It would be much better to return a properly formatted error, with suggestions to help the user fix issues.
 - Money library - Floats are not perfectly precise, and not really suited to handle money, balances, or transactions. It would be much better to use a more advanced tool for money manipulation.


