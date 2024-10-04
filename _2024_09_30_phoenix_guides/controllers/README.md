# Phoenix Controllers

Phoenix controllers act as an intermediary between routes and views. They contain functions (called actions) that are invoked by routes and return rendered views or JSON responses.

## Controllers as Plugs

Controllers are built on plugs and are themselves plugs.

## Actions

Actions are simply functions.  While they can have any valid Elixir function name, it's crucial that the action name matches the atom used in the corresponding route.  This ensures proper routing.

While naming is flexible, following conventions improves code readability and maintainability:

* **`index`**: Renders a list of all items.
* **`show`**: Renders an individual item by ID.
* **`new`**: Renders a form for creating a new item.
* **`create`**: Receives parameters for a new item and saves it.
* **`edit`**: Retrieves an item by ID and displays it in an editable form.
* **`update`**: Receives parameters for an edited item and saves the changes.
* **`delete`**: Receives an ID for an item and deletes it.

Each action receives two arguments:

1. `conn`: A `Plug.Conn` struct containing request information (host, path, query string, etc.).
2. `params`: A map containing parameters from the HTTP request.

Pattern matching in function signatures is recommended:

```elixir
defmodule HelloWeb.HelloController do
  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
end
```

## Rendering

Phoenix provides several functions for rendering responses:

* **`text/2`**: Returns plain text.
* **`json/2`**: Returns a JSON representation of a map (using the Jason library).
* **`html/2`**: Returns HTML.  Less preferred than `render/3`.
* **`render/3`**: Renders a template through a Phoenix View.  This is the preferred method for HTML and other formats due to performance and security benefits.

### Views and Templates

For `render/3`, the controller and view modules should share a root name (e.g., `TestController` and `TestView`). The view module needs to specify `embed_templates` and the directory containing the templates.  Templates are named after the corresponding action (e.g., `show.html.heex` for the `show` action).

Values are passed to templates using keyword arguments in `render/3`:

```elixir
render(conn, :show, any_value: value)
```

Alternatively, values can be assigned to the `conn` struct using `Plug.Conn.assign/3` (or just `assign/3` as `Plug.Conn` is imported by default in controllers):

```elixir
def show(conn, %{"messenger" => messenger}) do
  conn
  |> assign(:messenger, messenger)
  |> assign(:receiver, "Dweezil")
  |> render(:show)
end
```

Views are not limited to HTML; they can render any format (JSON, CSV, etc.).

### Other Response Options

* **`Plug.Conn.send_resp/3`**: Sends a response without a body.

```elixir
def home(conn, _params) do
  send_resp(conn, 201, "")
end
```

* **`put_resp_content_type/2`**: Sets the response content type.

```elixir
def home(conn, _params) do
  conn
  |> put_resp_content_type("text/xml")
  |> render(:home, content: some_xml_content) # Requires home.xml.eex
end
```

## Setting the HTTP Status

Use `Plug.Conn.put_status/2` (or just `put_status/2`) to set the HTTP status code:

```elixir
def home(conn, _params) do
  conn
  |> put_status(202)
  |> render(:home, layout: false)
end
```

## Redirection

Use `redirect/2` for redirects within the application (`to:`) or to external websites (`external:`):

```elixir
# Internal redirect
redirect(conn, to: ~p"/redirect_test")

# External redirect
redirect(conn, external: "https://elixir-lang.org/")
```


## Flash Messages

Use `put_flash/3` to set flash messages:

```elixir
conn
|> put_flash(:error, "Let's pretend we have an error.")
|> render(:home, layout: false)
```

Retrieve flash messages with `Phoenix.Flash.get/2`:


## Error Pages

Phoenix provides `ErrorHTML` and `ErrorJSON` views for handling errors.  These views are responsible for rendering error pages in different formats.
