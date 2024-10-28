## Building Secure APIs with Phoenix: A Beginner's Guide to Authentication

First the Auth scaffold need to be present:

```
$ mix phx.gen.auth Accounts User users
```

If your command used different names (e.g., `mix phx.gen.auth Authentication User users`), adjust the code examples accordingly.

### Part 1: Enhancing the Context

The `Accounts` context (located at `lib/my_app/accounts.ex`) manages user accounts and needs two new functions: one to create API tokens and another to verify them.

**1. Create API Token:**

```elixir
def create_user_api_token(user) do
    {encoded_token, user_token} = UserToken.build_email_token(user, "api-token")
    Repo.insert!(user_token)
    encoded_token
end
```

This function generates a unique, encoded token for the provided `user`, stores the token information in the database, and returns the encoded token.  Critically, it leverages the `UserToken` module's existing functionality, specifically designed for secure token management. The token type is designated as "api-token".  Since it's treated as an email token, it will automatically expire if the user changes their email address, enhancing security.

**2. Verify API Token:**

```elixir
def fetch_user_by_api_token(token) do
    with {:ok, query} <- UserToken.verify_email_token_query(token, "api-token"),
         %User{} = user <- Repo.one(query) do
      {:ok, user}
    else
      _ -> :error
    end
end
```

This function attempts to verify the provided `token`.  It uses `UserToken.verify_email_token_query` to check if the token is valid and unexpired. If successful, it retrieves the associated user from the database. The function returns `{:ok, user}` upon successful verification and `:error` otherwise. This allows your controllers to handle different scenarios based on the outcome.

**3. Testing the Context:**

Add the following test to `test/my_app/accounts_test.exs`:

```elixir
describe "create_user_api_token/1 and fetch_user_by_api_token/1" do
    test "creates and fetches by token" do
      user = user_fixture()
      token = Accounts.create_user_api_token(user)
      assert Accounts.fetch_user_by_api_token(token) == {:ok, user}
      assert Accounts.fetch_user_by_api_token("invalid") == :error
    end
end
```

**4. Define Token Validity:**

The tests will initially fail because we haven't specified how long "api-token" tokens remain valid. Open `lib/my_app/accounts/user_token.ex` and add:

```elixir
defp days_for_context("api-token"), do: 365 # Example: valid for 365 days
```

This tells the system that "api-token" tokens expire after 365 days.  Adjust this duration based on your security requirements. Now the tests should pass.

### Part 2: The Authentication Plug

A "plug" is a module that processes requests in a Phoenix application. We'll create a plug to handle API authentication.

**1. Create the `fetch_api_user` Plug:**

In `lib/my_app_web/user_auth.ex`, add:

```elixir
def fetch_api_user(conn, _opts) do
  with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
       {:ok, user} <- Accounts.fetch_user_by_api_token(token) do
    assign(conn, :current_user, user)
  else
    _ ->
      conn
      |> send_resp(:unauthorized, "No access for you")
      |> halt()
  end
end
```

This plug checks the `authorization` header for a token in the format "Bearer TOKEN". If the token is valid, it assigns the authenticated user to `conn.assigns.current_user`. If not, it halts the request with an unauthorized error.

**2. Add the Plug to the API Pipeline:**

In `lib/my_app_web/router.ex`, modify your API pipeline:

```elixir
pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_api_user
end
```

Now all requests passing through this pipeline will be authenticated using your new plug.

### Next Steps

**Client-Side Implementation:**  You'll need to send the "Bearer TOKEN" in the `authorization` header of every API request.  Here's a JavaScript example:

```javascript
fetch('/api/some_endpoint', {
  headers: {
    'Authorization': 'Bearer ' + your_api_token
  }
})
```

**Token Creation for Users:**  You'll need to expose an endpoint where users can create their API tokens. Modify the `UserSessionController` to call `Accounts.create_user_api_token/1` after successful login and return the token in a JSON response.

**Third-Party APIs:** For external users, create a registration/login flow where they can generate and manage their API tokens. Ensure they understand the importance of storing their tokens securely.

**Testing:** Write tests in `test/my_app_web/user_auth_test.exs` to ensure your authentication plug functions correctly.
