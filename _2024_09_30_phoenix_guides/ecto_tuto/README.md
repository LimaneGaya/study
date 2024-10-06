# Ecto Tutorial: Interacting with Databases in Elixir

Ecto is a powerful Elixir library that simplifies database interactions, providing a robust and flexible way to manage data persistence in your applications. This tutorial covers essential aspects of Ecto, from setting up a database connection to performing complex queries.

## Creating a Database and Schema

1. **Create the Database:**
   ```bash
   mix ecto.create
   ```
   This command creates the database based on your configuration (more on this later).

2. **Generate a Schema:**
   Ecto uses schemas to map Elixir structs to database tables.  Let's create a `User` schema:
   ```bash
   mix phx.gen.schema User users name:string email:string bio:text number_of_pets:integer
   ```
   This generates two crucial files:

   * `user.ex`: Defines the `User` schema, including field types and validations.
   * A migration file in `priv/repo/migrations/`: Contains instructions to create the `users` table in the database.  Note that an `id` field (primary key) is automatically added, even if not explicitly specified.

3. **Run the Migration:**
   ```bash
   mix ecto.migrate
   ```
   This applies the migration, creating the `users` table in the development database. For production:
   ```bash
   MIX_ENV=prod mix ecto.migrate
   ```

**Example Migration File:**

```elixir
defmodule YourApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :bio, :text # Use :text for longer strings
      add :number_of_pets, :integer

      timestamps() # Adds inserted_at and updated_at timestamps
    end
  end
end
```

## Repository Configuration

The `YourApp.Repo` module (e.g., `Hello.Repo` in the original example) is the central point for database interaction. It handles connection pooling, adapter communication, and error handling.

**Example `repo.ex` (PostgreSQL):**

```elixir
defmodule YourApp.Repo do
  use Ecto.Repo,
    otp_app: :your_app, # Replace with your app's name
    adapter: Ecto.Adapters.Postgres
end
```

**Database Configuration (in `config/` files):**

* **`dev.exs` (Development):**
  ```elixir
  config :your_app, YourApp.Repo,
    username: "postgres",
    password: "postgres",
    hostname: "localhost",
    database: "your_app_dev", # Development database name
    show_sensitive_data_on_connection_error: true,
    pool_size: 10
  ```

* **`test.exs` (Testing):** Similar to `dev.exs` but with a different database name (e.g., `your_app_test`).

* **`runtime.exs` (Production):**  Configure environment variables for sensitive information like database credentials.  This ensures they are not hardcoded in your configuration files.

* **SQLite Example (in `dev.exs`):**
    ```elixir
    config :ecto_tuto, EctoTuto.Repo,
      database: Path.expand("../ecto_tuto_dev.db", __DIR__),
      pool_size: 5,
      stacktrace: true,
      show_sensitive_data_on_connection_error: true
    ```


## Schemas and Changesets

Schemas define the structure of your data, while changesets provide a mechanism for validating and transforming data before it's persisted to the database.

**Example Changeset:**

```elixir
defmodule YourApp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :text
    field :number_of_pets, :integer

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :bio, :number_of_pets])
    |> validate_required([:name, :email, :bio, :number_of_pets]) # Ensure these fields are present
  end
end
```

* `cast/3`: Selectively updates fields in the schema based on the provided `attrs` map.  It helps prevent unwanted modifications by only allowing changes to specified fields.
* `validate_required/2`: Ensures that the specified fields are present and not empty.


**Other Validations:**

* `validate_length/3`:  Validates the length of a string field (e.g., `validate_length(:bio, min: 2, max: 140)`).
* `validate_format/3`: Uses regular expressions to validate the format of a field (e.g., `validate_format(:email, ~r/@/)`).
* `validate_inclusion/3`:  Checks if a value is within a given range (e.g., `validate_inclusion(:age, 18..100)`).
* `validate_number/3`: Validates number fields (e.g., `validate_number(:number_of_pets, greater_than_or_equal_to: 0)`).


## Data Persistence

The `Repo` module provides functions for interacting with the database:

* `Repo.insert/2`: Inserts a new record. Accepts a schema struct or a changeset. If a changeset is invalid, it returns an error tuple `{:error, changeset}`.
* `Repo.all/1`: Retrieves all records from a table. Accepts an Ecto query.
* `Repo.one/1`: Retrieves a single record.  Raises an error if no record or multiple records are found.
* `Repo.get/2`: Retrieves a record by its primary key.
* `Repo.update/2`: Updates an existing record. Takes a schema struct or changeset.
* `Repo.delete/2`: Deletes a record.

**Ecto Queries:**

Ecto provides a powerful query language:


```elixir
import Ecto.Query # Import the query functions

# Select all emails
Repo.all(from u in YourApp.User, select: u.email)

# Count users with "1" in their email
Repo.one(from u in YourApp.User, where: ilike(u.email, "%1%"), select: count(u.id))

# Map user IDs to emails
Repo.all(from u in YourApp.User, select: %{u.id => u.email})
```


**Bulk Operations:**

* `Repo.insert_all/3`
* `Repo.update_all/3`
* `Repo.delete_all/2`


## Using Other Databases

To create a new Phoenix project with a specific database (e.g., MySQL):

```bash
mix phx.new your_app --database mysql
```

To change the database for an existing project:

1. **Update Dependencies:**  Remove the old database adapter dependency and add the new one in your `mix.exs` file.
2. **Configure the Repo:** Change the `:adapter` in your `repo.ex` file.
3. **Update Configuration:**  Adjust the database connection details in `config/dev.exs`, `config/test.exs`, and `config/runtime.exs`.
4. **Create and Migrate:**
   ```bash
   mix deps.get
   mix ecto.create
   mix ecto.migrate
   ```

Ecto supports various databases, including PostgreSQL, MySQL, MSSQL, and SQLite. You can also use alternative storage mechanisms like ETS, DETS, and Mnesia (though these are not relational databases and don't use Ecto directly). They are Erlang Term Storage, Disk Erlang Term Storage, and distributed database respectively. They are specific to the Erlang/Elixir ecosystem.  They offer different performance characteristics and features compared to traditional relational databases.  You might choose them for specific use cases like caching, managing application state, or handling data within a distributed Erlang system.  However, for most general-purpose data persistence needs, a relational database managed via Ecto is usually the preferred approach.
