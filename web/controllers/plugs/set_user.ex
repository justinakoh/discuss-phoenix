defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User
  alias Discuss.Router.Helpers

# This is called whenever the code is booted up
  def init(_params) do

  end

# This is called whenever the plug runs. This must receive a connection and return a connection
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    # This looks like a case statement but it work slightly differently.
    # It looks at all the different boolean statements, and the first one which is true is returned
    cond do
      # This not only is used as a truthy statement, but it also assigns a value to ther user_id vairable
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end

end
