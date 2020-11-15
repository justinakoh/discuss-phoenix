defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.{Topic, Comment}

  # <> is how we join strings together in Elixir. IN this case we use it with pattern matching to get the correct id
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Topic, topic_id)
    {:ok, %{}, assign(socket, :topic, topic)}

    # {:ok, %{my_header: "my_reply"}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
      |> build_assoc(:comments)
      |> Comment.changeset(%{content: content})
      IO.inspect("++++++++++++++++++++++++++++++++++++++++++++")
      IO.inspect(changeset)
      IO.inspect("++++++++++++++++++++++++++++++++++++++++++++")

    case Repo.insert(changeset) do
      {:ok, comment} ->
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
