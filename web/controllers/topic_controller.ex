defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  # When things are being posted: here we want to handle both cases where things are successful and also where there is an error
  def create(conn, %{"topic" => topic}) do
    # this is the change that we want to make to our database:as we are creating something new we pass in an empty struct i.e. %Topic{}
    # If we were going to edit something we would pass in a struct with a title and id
    changeset = Topic.changeset(%Topic{}, topic)


    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post)
      {:error, changeset} -> IO.inspect(changeset)
    end

  end

end
