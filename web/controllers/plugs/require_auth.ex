defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  def init(_params) do
  end

  #This is called after init.
  # This returns conn as it the next thing to do after this is assign/3
  def call(conn, _params) do
  # User is signed in,return the conn so that they can do other actions
    if conn.assigns[:user] do
      conn
      # Not signed in, don't let them do much
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end

  end

end
