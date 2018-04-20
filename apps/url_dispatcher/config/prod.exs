use Mix.Config

config :url_dispatcher,
  ecto_repos: [],
  serve_endpoints: true,
  start_with_no_watch: true,
  port: {:system, "PORT", 4000}
