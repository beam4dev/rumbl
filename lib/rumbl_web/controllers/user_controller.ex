defmodule RumblWeb.UserController do
  alias Rumbl.Accounts
  use RumblWeb, :controller

  alias Rumbl.Accounts.User

  def index(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :index, users: Rumbl.Accounts.list_users())
  end

  def show(conn, %{"id" => id}) do
    # The home page is often custom made,
    # so skip the default app layout.
    user = Rumbl.Accounts.get_user(id)
    render(conn, :show, user: user)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: ~p{/users})

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
