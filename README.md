# ApiSandboxChallenge

## Setup
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000/accounts/?username=test_token_347264212) from your browser

## Url Structure

Url Structure is (base/) (endpoint/) (token)

(http://localhost:4000/) (accounts/) (?username=test_token_347264212)

The token value can be any 9 digit integer that does not start with 0

It should be possible to navigate almost the entire app using the returned links from each endpoint

## Urls for token 732645231

http://localhost:4000/accounts/?username=test_token_732645231

http://localhost:4000/accounts/acc_98ligqgnowb0bd3v0brq?username=test_token_732645231




(besides learning Elixir and Phoenix)

A lot of the work for this project was spent on building a procedural generator from scratch that was capable of returning consistent yet varied results.
