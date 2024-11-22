## Understanding Phoenix Controller Testing in Elixir

### **Testing HTML Controllers**

#### **Setting up Tests**

Controller tests are found in the `test/hello_web/controllers` directory. The test module starts with:

```elixir
defmodule HelloWeb.PostControllerTest do
  use HelloWeb.ConnCase
  import Hello.BlogFixtures
  # ... test definitions ...
end
```

*   `use HelloWeb.ConnCase`: Sets up the necessary environment for testing connections.
*   `import Hello.BlogFixtures`: Imports functions to create test data.

#### **Testing the `index` action**

The `index` action lists all posts.

```elixir
describe "index" do
  test "lists all posts", %{conn: conn} do
    conn = get(conn, ~p"/posts")
    assert html_response(conn, 200) =~ "Listing Posts"
  end
end
```

*   `get(conn, ~p"/posts")`: Makes a GET request to the `/posts` path.
*   `assert html_response(conn, 200)`: Asserts that the response is an HTML response with a status code of 200 (OK).
*   `=~ "Listing Posts"`: Asserts that the response body contains "Listing Posts".

#### **Testing the `create` action**

The `create` action handles the creation of new posts.

```elixir
describe "create post" do
  test "redirects to show when data is valid", %{conn: conn} do
    conn = post(conn, ~p"/posts", post: @create_attrs)
    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == ~p"/posts/#{id}"
    conn = get(conn, ~p"/posts/#{id}")
    assert html_response(conn, 200) =~ "Post #{id}"
  end

  test "renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, ~p"/posts", post: @invalid_attrs)
    assert html_response(conn, 200) =~ "New Post"
  end
end
```

*   `post(conn, ~p"/posts", post: @create_attrs)`: Makes a POST request to create a post.
*   `redirected_params(conn)`: Retrieves parameters from the redirect.
*   `redirected_to(conn)`: Checks the redirection path.

#### **Testing the `delete` action**

The `delete` action removes a post.

```elixir
describe "delete post" do
  setup [:create_post]

  test "deletes chosen post", %{conn: conn, post: post} do
    conn = delete(conn, ~p"/posts/#{post}")
    assert redirected_to(conn) == ~p"/posts"
    assert_error_sent 404, fn -> get(conn, ~p"/posts/#{post}") end
  end
end

defp create_post(_) do
  post = post_fixture()
  %{post: post}
end
```

*   `setup [:create_post]`: Runs `create_post` before each test to set up data.
*   `delete(conn, ~p"/posts/#{post}")`: Deletes the post.
*   `assert_error_sent 404`: Asserts that a 404 (Not Found) error is returned.

### **Testing JSON Controllers**

JSON controllers are used for APIs and return JSON data.

#### **Testing the `index` action**

The `index` action for JSON returns a list of articles.

```elixir
describe "index" do
  test "lists all articles", %{conn: conn} do
    conn = get(conn, ~p"/api/articles")
    assert json_response(conn, 200)["data"] == []
  end
end
```

*   `json_response(conn, 200)`: Asserts that the response is a JSON response with status 200.

#### **Testing the `create` action**

The `create` action for JSON creates a new article and returns it.

```elixir
describe "create article" do
  test "renders article when data is valid", %{conn: conn} do
    conn = post(conn, ~p"/articles", article: @create_attrs)
    assert %{"id" => id} = json_response(conn, 201)["data"]
    conn = get(conn, ~p"/api/articles/#{id}")
    assert %{"id" => ^id, "body" => "some body", "title" => "some title"} = json_response(conn, 200)["data"]
  end

  test "renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, ~p"/api/articles", article: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end
end
```

*   Status code 201 indicates successful creation.
*   Status code 422 indicates unprocessable entity (validation errors).

#### **Using Action Fallback**

To handle errors gracefully, use `action_fallback`:

```elixir
action_fallback HelloWeb.FallbackController
```

This invokes `FallbackController` when an action returns a non-`%Plug.Conn{}` result.

```elixir
defmodule HelloWeb.FallbackController do
  # ...
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    # ...
  end
  # ...
end
```

#### **Testing the `delete` action**

The `delete` action for JSON deletes an article and returns a 204 No Content response.

```elixir
describe "delete article" do
  setup [:create_article]

  test "deletes chosen article", %{conn: conn, article: article} do
    conn = delete(conn, ~p"/api/articles/#{article}")
    assert response(conn, 204)
    assert_error_sent 404, fn -> get(conn, ~p"/api/articles/#{article}") end
  end
end
```

*   `response(conn, 204)`: Asserts a 204 No Content response.

### **Key Commands and Concepts**

*   `mix phx.gen.html`: Generates an HTML resource.
*   `mix phx.gen.json`: Generates a JSON resource.
*   `use HelloWeb.ConnCase`: Sets up connection testing.
*   `get(conn, path)`: Makes a GET request.
*   `post(conn, path, params)`: Makes a POST request.
*   `delete(conn, path)`: Makes a DELETE request.
*   `assert html_response(conn, status)`: Asserts an HTML response with a given status.
*   `assert json_response(conn, status)`: Asserts a JSON response with a given status.
*   `redirected_to(conn)`: Checks the redirection path.
*   `redirected_params(conn)`: Retrieves parameters from the redirect.
*   `assert_error_sent status, function`: Asserts that a specific error is sent.
*   `setup`: Runs a function before each test.
*   `action_fallback`: Handles errors returned by actions.

### **Some Notes**

*   **Focus on Integration Testing**: Controller tests should focus on verifying the integration between different components.
*   **Test both success and failure scenarios**.
*   **Avoid testing detailed logic**: This should be done in context and schema tests.
*   **Use fixtures to create test data**: This ensures consistency and repeatability.
*   **Keep tests concise and readable**: Use descriptive names and avoid unnecessary complexity.
*   **Test API responses thoroughly**: Ensure correct status codes and response bodies.