# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :wrs_phoenix, WrsPhoenix.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "wrs_phoenix_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


# General application configuration
config :wrs_phoenix,
  ecto_repos: [WrsPhoenix.Repo]

# Configures the endpoint
config :wrs_phoenix, WrsPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OqyAqR0AIs9P4yC91tgzF0Awfm16PLl66YpmDwI+BZ3501bkDSeOAJxTacMlrsJx",
  render_errors: [view: WrsPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WrsPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
