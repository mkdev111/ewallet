defmodule EWalletDB.Repo.Seeds.UserSeed do
  alias EWalletDB.Helpers.Crypto

  @args_banner """
    ## What email and password should I set for your first admin user?

    This email and password combination is required for logging into the admin panel.
    If a user with this email already exists, it will escalate the user to admin role,
    but the password will not be changed.
  """

  def seed do
    [
      args: [
        {:admin_email, :email, "E-mail", "admin@example.com"},
        {:admin_password, :password, "Password", {Crypto, :generate, [16]}},
      ],
      args_banner: @args_banner,
      run_banner: "Seeding the initial admin panel user",
    ]
  end

  def run(_args) do
  end
end
