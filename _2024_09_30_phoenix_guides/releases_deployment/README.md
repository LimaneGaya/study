**What are Releases?**

Think of a release as a self-contained package. It bundles everything your Phoenix application needs to run: the Erlang Virtual Machine (the core of Elixir), Elixir itself, your application's code, and all the libraries it depends on (dependencies). This package can be easily deployed to a server without needing to install anything else.

**Steps to Create a Release**

1. **Prepare the environment:**
    *   Generate a secret key for your application:
        ```bash
        mix phx.gen.secret
        ```
        This command will output a long string. Copy it.
    *   Set environment variables:
        ```bash
        export SECRET_KEY_BASE=REALLY_LONG_SECRET # Replace with the copied secret
        export DATABASE_URL=ecto://USER:PASS@HOST/database # Replace with your database details
        ```
        These variables store sensitive information and configurations.

2. **Compile everything:**
    *   Get production dependencies:
        ```bash
        mix deps.get --only prod
        ```
        This downloads only the libraries needed for production.
    *   Compile the code:
        ```bash
        MIX_ENV=prod mix compile
        ```
        This translates your Elixir code into instructions the Erlang VM can understand.
    *   Compile assets (like JavaScript and CSS):
        ```bash
        MIX_ENV=prod mix assets.deploy
        ```
        This prepares your front-end code for production.

3. **Generate Release Files:**
    *   Run the release generator:
        ```bash
        mix phx.gen.release
        ```
        This command creates some helpful files and folders:
        *   `rel/overlays/bin/server` and `rel/overlays/bin/migrate`: Scripts to start your server and run database migrations within the release.
        *   `lib/my_app/release.ex`: An Elixir module to handle migrations and custom commands in the release. Replace `my_app` with your application's name.
        *   If you're using Docker, add the `--docker` flag: `mix phx.gen.release --docker`. This generates a `Dockerfile` to build a container image.

4. **Build the Release:**
    ```bash
    MIX_ENV=prod mix release
    ```
    This command assembles your application, dependencies, and the Erlang VM into a release package located in the `_build/prod/rel/my_app` directory.

**Running the Release**

Once the release is built, you can run it:

*   To start the entire system:

    ```bash
    _build/prod/rel/my_app/bin/my_app start
    ```
*   To start only the web server:

    ```bash
    _build/prod/rel/my_app/bin/server
    ```
*   To run database migrations:

    ```bash
    _build/prod/rel/my_app/bin/migrate
    ```
*   To connect to the running release remotely:

    ```bash
     _build/prod/rel/my_app/bin/my_app remote
    ```
*   To stop the release gracefully:

    ```bash
    _build/prod/rel/my_app/bin/my_app stop
    ```
    Alternatively, you can send SIGINT or SIGTERM signals.
*   To list all available commands:

    ```bash
    _build/prod/rel/my_app/bin/my_app
    ```

Remember to replace `my_app` with your application's name.

Now you can copy the entire `_build/prod/rel/my_app` directory to any production machine with the same operating system and architecture, and your application will run.

**Database Migrations and Custom Commands in Releases**

Since `mix` isn't available in a release, you need a different way to run migrations and other tasks. This is where the `lib/my_app/release.ex` file comes in. It provides functions to manage migrations:

*   `migrate`: Runs all pending migrations.
*   `rollback(repo, version)`: Reverts migrations to a specific version.

To execute these functions or any other custom code within the release, use the `eval` command:

```bash
_build/prod/rel/my_app/bin/my_app eval "MyApp.Release.migrate"
```

This runs the `migrate` function from the `MyApp.Release` module. You can add your own functions to this module for any custom tasks you need to perform in production.

**Advanced Tip: Custom Start Commands**

Sometimes you might want to customize how your application starts within a release. For example, you might want to start only certain parts of your application for specific tasks. You can achieve this by modifying the `release.ex` file:

```elixir
defmodule MyApp.Release do
  # ... other code ...

  defp start_app do
    load_app()
    Application.put_env(@app, :minimal, true) # Set a flag
    Application.ensure_all_started(@app) # Start all apps
  end
end
```

Then, in your application code, you can check this flag:

```elixir
  def start(_type, _args) do
      # other code ....

      children =
        if Application.get_env(@app, :minimal) do
          [
              # Start minimal set of children
          ]
        else
          [
             # Start all children
             MyAppWeb.Endpoint,
          ]
        end

      Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
    end
end
```

and start only the necessary parts of your supervision tree accordingly.

**Deploying with Docker**

Releases work exceptionally well with Docker. If you used the `--docker` flag when generating the release files, you'll have a `Dockerfile`. This file defines how to build a Docker image containing your application.

Here's a breakdown of the Dockerfile:

1. **Base Images:** It starts by defining a builder image (`hexpm/elixir`) with Elixir and Erlang installed and a runner image (`debian`) which is a minimal OS image with just the necessary dependencies to run your application.
2. **Build Stage:**
    *   It installs build dependencies (like a C compiler).
    *   It sets up the working directory.
    *   It installs Hex and Rebar (Elixir and Erlang build tools).
    *   It copies the `mix.exs` and `mix.lock` files, fetches dependencies, and compiles them.
    *   It copies your application code and assets.
    *   It compiles assets for production.
    *   It compiles the application.
    *   It copies the runtime configuration file (`config/runtime.exs`).
    *   It copies the release configuration and builds the release.
3. **Runner Stage:**
    *   It starts with the smaller runner image.
    *   It installs necessary runtime libraries.
    *   It sets the locale to UTF-8.
    *   It sets up the working directory and ownership.
    *   It copies only the built release from the builder stage.
    *   It sets the user to `nobody` for security.
    *   It sets the command to run your server (`/app/bin/server`).

**Building and Running the Docker Image**

To build the image:

```bash
docker build -t my-app .
```

Replace `my-app` with your desired image name.

To run the image:

```bash
docker run -p 4000:4000 -e DATABASE_URL="your_database_url" -e SECRET_KEY_BASE="your_secret_key" my-app
```

*   `-p 4000:4000` maps port 4000 on your host machine to port 4000 in the container.
*   `-e DATABASE_URL="..."` and `-e SECRET_KEY_BASE="..."` set the necessary environment variables.

**Container Configuration Tips**

*   **Endpoint Configuration:** Ensure your Phoenix endpoint is configured to listen on a public IP address (like `0.0.0.0`) so it can be accessed from outside the container.
*   **Runtime Configuration:** Use `config/runtime.exs` to configure as much as possible at runtime. This makes your Docker images more reusable. Sensitive information like database credentials and API keys should be provided as environment variables when running the container, not baked into the image.
*   **Environment Variables:** Read all necessary environment variables in `config/runtime.exs` to keep them centralized.
