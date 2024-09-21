defmodule ForumWeb.PostJSON do
  alias Forum.Posts.Post

  @doc """
  Renders a list of posts.
  """
  def index(%{posts: posts}) do
    %{posts: for(post <- posts, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{data: data(post)}
  end

  def data(%Post{} = post) do
    %{
      id: post.id,
      user_id: post.user_id,
      body: post.body,
      title: post.title
    }
  end
end
