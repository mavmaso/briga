# Briga
 
It’s an app for a multiplayer game that emulates a real-time fighting game, but based on cards.
The main inspiration for this game would be a mix of Street Fighter, JRPG, and Magic.

### Proposal Problem

  This app was built as a POC to learn/train liveview and get out of the comfort zone. Therefore, it was not always possible to apply the best patterns and architecture, sometimes due to lack of knowledge or to test how far a certain concept could go.But without forgetting to write clean code and do our best to deliver within the limitations.

## Deps for Linux

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install -y build-essential libssl-dev zlib1g-dev automake autoconf libncurses5-dev`

## In loco Setup

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`
- Run complete tests `mix test`

## Docker
- docker-compose build
- docker-compose run --rm web mix deps.get
- docker-compose run --rm web mix ecto.setup
- docker-compose run --rm web mix test
- docker-compose up --force-recreate

## Database
  PostgreSQL
  ```
  username: postgres
  password: postgres
  ```

## Using

 You can use 

### Endpoint

 - "/"
 - "/battle"

## Made by

 - [mavmaso](https://github.com/mavmaso)