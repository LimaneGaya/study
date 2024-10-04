# Phoenix Function Components, HEEx, and Layouts

## Function Components

Function components are the final step in a Phoenix request where HTML is rendered. They're used to render data into markup-based templates.  These components promote reusability and maintainability within your application.

Consider a simple template:

```html
<section>
  <h2>Hello World, from <%= @messenger %>!</h2>
</section>
```

This template can be converted into a function component within a module, usually located in `lib/project_web/controllers/project_html.ex`:

```elixir
defmodule ProjectWeb.ProjectHTML do
  use ProjectWeb, :html

  embed_templates "project_html/*"

  attr :messenger, :string, required: true

  def greet(assigns) do
    ~H"""
    <h2>Hello World, from <%= @messenger %>!</h2>
    """
  end
end
```

Templates are embedded as part of this module using `embed_templates/1`. Functions declared within this module become accessible from all templates because templates are effectively converted into functions within the module.

Now, you can use the function component within other templates:

```html
<section>
  <.greet messenger={@messenger} />
</section>
```

### The `attr` Macro

The `attr/3` macro, provided by `Phoenix.Component`, is crucial for defining the attributes (arguments) a component accepts.  In the example above, `attr :messenger, :string, required: true` defines a required attribute named `messenger` of type `string`.  If the component is called without this attribute, the compiler will issue a warning.

Attributes can also be optional and have default values:

```elixir
attr :messenger, :string, default: nil
```

If a component is defined in a different module, it can be invoked using its fully qualified name, for example: `<HelloWeb.HelloHTML.greet messenger="..." />`.


## HEEx Templates

Function components and templates are powered by the HEEx template language, which stands for "HTML+EEx". EEx (Embedded Elixir) allows embedding Elixir code within templates using `<%= expression %>`.  This is primarily used to display assigns passed from controllers, e.g., `render(conn, :show, username: "joe")`.

### Conditionals and Loops

EEx handles conditionals and loops seamlessly within HTML:

```html
<%= if some_condition? do %>
  <p>Some condition is true for user: <%= @username %></p>
<% else %>
  <p>Some condition is false for user: <%= @username %></p>
<% end %>
```

```html
<table>
  <tr>
    <th>Number</th>
    <th>Power</th>
  </tr>
  <%= for number <- 1..10 do %>
    <tr>
      <td><%= number %></td>
      <td><%= number * number %></td>
    </tr>
  <% end %>
</table>
```

The difference between `<%= %>` and `<% %>` is the `=`.  With `=`, the result of the Elixir expression is inserted into the template. Without it, the code is executed, but the output isn't rendered.

### HTML Extensions and Safety

HEEx provides mechanisms for handling HTML safely and efficiently.

* **Escaping:** By default, HEEx escapes HTML tags.  `<%= "<b>Bold?</b>" %>` will render the string as plain text, displaying the tags literally. This prevents cross-site scripting (XSS) vulnerabilities.
* **`raw`:** The `raw` function can be used to render unescaped HTML.  `<%= raw "<b>Bold?</b>" %>` will render the `<b>` tag as HTML, making the text bold.  **Use `raw` with extreme caution**, as it can introduce XSS vulnerabilities if used with untrusted user input. Sanitize any user-provided HTML before rendering it with `raw`.
* **Attribute Splatting:** HEEx supports streamlined attribute rendering. Instead of writing individual attributes, you can use `{@many_attributes}` to inject multiple attributes at once. This is useful for dynamically generating attributes. For example:

```html
<div title="My div" {@many_attributes}>
  ...
</div>
```

* **Shorthand Conditionals and Loops:** HEEx offers shorthand syntax for `if` and `for`:

```html
<div :if={@some_condition}>...</div>

<ul>
  <li :for={item <- @items}><%= item.name %></li>
</ul>
```


## Layouts

Layouts are essentially function components that wrap other templates. They provide a consistent structure for your application, including headers, footers, and navigation. Layouts are defined in HEEx files within the `lib/hello_web/components/layouts` directory.

By default, Phoenix uses a layout (usually `root.html.heex`).  To disable the layout for a specific action:

```elixir
def index(conn, _params) do
  conn
  |> put_root_layout(html: false) # Disables the root layout
  |> render(:index)
end
```

To use a different layout (e.g., `admin.html.heex` in `lib/hello_web/components/layouts`):


```elixir
def index(conn, _params) do
  conn
  |> put_layout(html: :admin) # Use the admin layout
  |> render(:index)
end
```

`put_layout(html: :atom)` uses the layout file named `atom.html.heex` within the layouts directory.  For example, `put_layout(html: :application)` would use `application.html.heex`.
