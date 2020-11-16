defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.{Topic, Comment}

  # <> is how we join strings together in Elixir. IN this case we use it with pattern matching to get the correct id
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)       #Find a TOPIC with the given topic_id
      |> Repo.preload(:comments)  #When you find that topic, go to the collection database and find every topic ID with the previuos found ID

    # we want to return all the other comments that have been added to that topic
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> build_assoc(:comments)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        #This updates the latest / just submitted comment onto the screen
        broadcast!(
          socket, "comments:#{socket.assigns.topic.id}:new",
          %{comment: comment
        })
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
