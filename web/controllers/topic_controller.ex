defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  # This uses a guard plu
  plug Discuss.Plugs.RequireAuth  when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  # This gets the records out from the database
  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)

    # Specifying which template we want to render
    render conn, "index.html", topics: topics
  end

  # When things are being posted: here we want to handle both cases where things are successful and also where there is an error
  def create(conn, %{"topic" => topic}) do
    changeset = conn.assigns.user   #This gets the current user off the current object
      |> build_assoc(:topics)       #Pipes current user into here. This makes a topic struct
      |> Topic.changeset(topic)     #Struct passed in. Has a reference to the current user - so the thing that gets created has a reference to the current user

    #Puts it into the database
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created") #put_flash is how we show ONE TIME messages to the user
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end

  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id) #This pulls the existing thing from the database
    changeset = Topic.changeset(topic) #WE then make a chageset with the stuff that came out of teh database

    render conn, "edit.html", changeset: changeset, topic: topic
  end


  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

    # You will see this over and over again in all sorts of different code
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created") #put_flash is how we show ONE TIME messages to the user
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  #This should check thr user ID to prevent people from forcing and sending their own requests directly to the system
  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id) #Bang (!) throws an error if it can't find it
    render conn, "show.html", topic: topic
  end

end
