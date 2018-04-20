defmodule EWalletDB.ReleaseTasks do
  @moduledoc """
  Provides a task for use within release.
  """

  @app_name :ewallet_db
  @start_apps [:crypto, :ssl, :postgrex, :ecto]

  def initdb do
    :ok = Application.load(@app_name)
    repos = Application.get_env(@app_name, :ecto_repos, [])

    Enum.each(@start_apps, &Application.ensure_all_started/1)
    Enum.each(repos, &(&1.start_link(pool_size: 1)))
    Enum.each(repos, &run_create_for/1)
    Enum.each(repos, &run_migrations_for/1)

    :init.stop()
  end

  defp run_create_for(repo) do
    case repo.__adapter__.storage_up(repo.config) do
      :ok -> IO.puts "The database for #{inspect repo} has been created"
      {:error, :already_up} -> IO.puts "The database for #{inspect repo} has already been created"
      {:error, term} when is_binary(term) -> IO.puts "The database for #{inspect repo} couldn't be created: #{term}"
      {:error, term} -> IO.puts "The database for #{inspect repo} couldn't be created: #{inspect term}"
    end
  end

  defp run_migrations_for(repo) do
    migrations_path = priv_path_for(repo, "migrations")
    IO.puts "Running migration for #{inspect repo}..."
    Ecto.Migrator.run(repo, migrations_path, :up, all: true)
  end

  defp priv_dir(app), do: "#{:code.priv_dir(app)}"
  defp priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)
    repo_underscore = repo |> Module.split |> List.last |> Macro.underscore
    Path.join([priv_dir(app), repo_underscore, filename])
  end
end
