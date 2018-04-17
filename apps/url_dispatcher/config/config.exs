use Mix.Config

config :url_dispatcher,
  ecto_repos: [],
  port: {:system, "PORT", 4000}
