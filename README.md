# Briga

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Commands

docker build . -t briga:0.1
docker run --env-file .env -p 4000:4000 briga:0.1

docker-compose up -d

npm install chromedriver --save-dev --prefix assets

brew install --cask chromedriver
brew upgrade --cask chromedriver

xattr -d com.apple.quarantine /opt/homebrew/bin/chromedriver

MIX_ENV=test mix e2e