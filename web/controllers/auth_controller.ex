defmodule Discuss.AuthController do
  use Discuss.Web, :controller

  # New Version
  # pipeline :browser do
  #   plug Ueberauth

  plug Ueberauth

  def callback(conn, params) do
  end
end
