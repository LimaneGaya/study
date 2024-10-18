# JSON and APIs in Phoenix

## Generating a JSON API

To scaffold a JSON API in Phoenix, the `mix phx.gen.json` command is used. For example:

```bash
mix phx.gen.json Urls Url urls link:string title:string
```

This command generates the following:

1. **Controller and Views** for handling the API endpoints and JSON rendering:
   - `lib/hello_web/controllers/url_controller.ex`
   - `lib/hello_web/controllers/url_json.ex`
   - `lib/hello_web/controllers/changeset_json.ex`
   - `lib/hello_web/controllers/fallback_controller.ex`

2. **Context and Schemas** for defining the business logic and interacting with the database:
   - `lib/hello/urls.ex`
   - `lib/hello/urls/url.ex`

3. **Migration File** to define the database schema:
   - `priv/repo/migrations/XXXXXXXXXXXX_create_urls.exs`

### Router Configuration

To expose the URL resource, add the following to the `lib/hello_web/router.ex` file under the API scope:

```elixir
scope "/api", HelloWeb do
  pipe_through :api
  resources "/urls", UrlController, except: [:new, :edit]
end
```

This configures the routes for the URLs API and uses the `:api` pipeline to handle JSON requests.

### Running Database Migrations

After generating the resources, update the database schema by running the migration:

```bash
mix ecto.migrate
```

---

## Rendering JSON

In Phoenix, rendering JSON in controllers is straightforward. The controller uses the `render/3` function, which works similarly to rendering HTML. For example, the `index` action in the `UrlController`:

```elixir
def index(conn, _params) do
  urls = Urls.list_urls()
  render(conn, :index, urls: urls)
end
```

### JSON View

The rendering logic is defined in a JSON view, `lib/hello_web/controllers/url_json.ex`. For instance:

```elixir
defmodule HelloWeb.UrlJSON do
  alias Hello.Urls.Url

  def index(%{urls: urls}) do
    %{data: for(url <- urls, do: data(url))}
  end

  def show(%{url: url}) do
    %{data: data(url)}
  end

  defp data(%Url{} = url) do
    %{
      id: url.id,
      link: url.link,
      title: url.title
    }
  end
end
```

This view formats the data into Elixir data structures that are encoded into JSON using the `Jason` library before sending it to the client.

---

## Action Fallback

Phoenix provides **Action Fallback** to centralize error handling in one place. This feature is useful when different actions in the controller need to return different error responses.

A fallback controller is defined as follows:

```elixir
defmodule HelloWeb.MyFallbackController do
  use Phoenix.Controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: HelloWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(json: HelloWeb.ErrorJSON)
    |> render(:"403")
  end
end
```

This controller handles errors like `:not_found` or `:unauthorized` and renders the appropriate error views. To use this fallback in a controller, the `action_fallback` macro is applied:

```elixir
defmodule HelloWeb.MyController do
  use Phoenix.Controller

  action_fallback HelloWeb.MyFallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- fetch_post(id) do
      render(conn, :show, post: post)
    end
  end
end
```

This reduces code repetition when handling errors across multiple actions.

---

## Handling Changeset Errors

Phoenix-generated JSON APIs handle validation errors using **changesets**. The fallback controller can handle errors returned by changesets, converting them into JSON.

For example, in the `FallbackController`, the following clause handles changeset errors:

```elixir
def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
  conn
  |> put_status(:unprocessable_entity)
  |> put_view(json: HelloWeb.ChangesetJSON)
  |> render(:error, changeset: changeset)
end
```

In `lib/hello_web/controllers/changeset_json.ex`, the `ChangesetJSON` module defines how changeset errors are formatted into JSON:

```elixir
defmodule HelloWeb.ChangesetJSON do
  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end
end
```

This converts the changeset's validation errors into a JSON object, which is then returned to the client.

### Changeset Validation

The changeset itself is responsible for casting and validating data. For example, in `lib/hello/urls/url.ex`:

```elixir
def changeset(url, attrs) do
  url
  |> cast(attrs, [:link, :title])
  |> validate_required([:link, :title])
end
```

This example ensures that both `link` and `title` fields are required. If validation fails, the fallback controller will render the appropriate error response.

---

## API-Only Phoenix Applications

Phoenix can be configured to generate API-only applications. To exclude unnecessary features like HTML views and assets, the following flags can be passed to `mix phx.new`:

- **`--no-html`**: Exclude HTML views.
- **`--no-assets`**: Exclude asset management (like JavaScript and CSS).
- **`--no-gettext`**: Skip internationalization setup.
- **`--no-dashboard`**: Exclude the Phoenix LiveDashboard.
- **`--no-mailer`**: Skip mailer setup (like Swoosh).

To create an API-only Phoenix project:

```bash
mix phx.new my_api --no-html --no-assets --no-gettext
```

This generates a minimal Phoenix application focused on API functionality. However, Phoenix can still support both REST APIs and web frontends within the same project if needed.

---

## Key Takeaways

- Use `mix phx.gen.json` to quickly scaffold JSON APIs.
- Configure the API routes in `router.ex` under an API scope.
- Implement JSON views to structure data for JSON responses.
- Use action fallback to handle errors centrally, avoiding repetitive error handling.
- Changeset errors are handled and rendered as JSON for validation feedback.
- API-only Phoenix applications can be generated using the appropriate `--no-*` flags to exclude unnecessary web app features.

This guide covers the essential aspects of building and handling JSON-based APIs in Phoenix.
