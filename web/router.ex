defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    # These are module plugs
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    # This is a moduleplug
    plug Discuss.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # This only works if you follow restful conventions
    resources "/", TopicController

  end


  scope "/auth", Discuss do
    pipe_through :browser

    get "/signout", AuthController, :signout

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
  # scope "/auth", Discuss do
  #   pipe_through :browser
  #
  #   get "/:provider", AuthController, :request
  #   get "/:provider/callback", AuthController, :callback
  # end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
