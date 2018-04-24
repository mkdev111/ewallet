defmodule EWallet.Seeder.CLI do
  alias EWallet.Seeder

  def run(app_name) do
    mods = Seeder.gather_seeds(app_name)
    IO.inspect(mods)
  end
end
