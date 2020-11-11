defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  # This gets the records out from the database
  def index(conn, _params) do
    topics = Repo.all(Topic)

    # Specifying which template we want to render
    render conn, "index.html", topics: topics
  end

  # When things are being posted: here we want to handle both cases where things are successful and also where there is an error
  def create(conn, %{"topic" => topic}) do
    # this is the change that we want to make to our database:as we are creating something new we pass in an empty struct i.e. %Topic{}
    # If we were going to edit something we would pass in a struct with a title and id
    changeset = Topic.changeset(%Topic{}, topic)


    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post)
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end

end
