# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CuKI0ycLlM6W4jgMo3kiWBIc9FKwtgNejanVnH3j0L0lvsDcIKTxbLhUmVeIt8S5",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"


config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

# config :ueberauth, Ueberauth.Strategy.Github.OAuth,
#   client_id: System.get_env("a299652855af776a0523"),
#   client_secret: System.get_env("1411547a35921a33da960ff0816cf1937dcaf2d9")

#This is for configuration
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  # RedirectURL: "postmessage",
  client_id: "a299652855af776a0523",
  client_secret: "1411547a35921a33da960ff0816cf1937dcaf2d9"
