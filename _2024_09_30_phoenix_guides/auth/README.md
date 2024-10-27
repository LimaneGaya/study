The `mix phx.gen.auth` command in Phoenix generates a flexible, built-in authentication system in your Phoenix application, allowing you to quickly implement user authentication with features like login, registration, password reset, and account confirmation. This guide will break down how to use `mix phx.gen.auth` and customize it to suit your needs, covering commands, generated code, and configuration tips.


## **Setup: Running `mix phx.gen.auth`**

```bash
mix phx.gen.auth Accounts User users
```

Here’s what each part means:

- **`Accounts`** is the context (a way to group related functionality).
- **`User`** is the schema module for storing user info.
- **`users`** is the plural version of `User`, used to name tables and routes.

### LiveView vs. Controller-Based Authentication

When prompted to choose between **Phoenix LiveView** (default) or **Controller-only** options, select `Y` (Yes) for LiveView, which adds interactive, real-time capabilities to your app’s interface. Or, type `n` for a simpler, non-interactive setup using controllers only.

After generating the authentication code, run:

```bash
mix deps.get
```

This command fetches additional dependencies for the generated code.

## **Database Setup**

1. **Configure Database**: Check the `config/` directory for database details in the `dev` and `test` environment files to ensure connections work correctly.
2. **Set up the Database**: Run migrations to set up the required tables:

   ```bash
   mix ecto.setup
   ```

3. **Test the Setup**: Make sure everything works by running tests:

   ```bash
   mix test
   ```

4. **Start the Server**: Test the authentication by running the server:

   ```bash
   mix phx.server
   ```

## **Customizing the Authentication System**

Since `mix phx.gen.auth` directly generates code within your application, you have full control to modify and expand it as needed. However, Phoenix won’t update this code for you as it evolves. For updates (especially security improvements), refer to the **CHANGELOG.md** in the generator’s repository to apply any crucial changes manually.

## **Understanding the Generated Code**

The generated authentication code provides a robust foundation, including:

### 1. **Password Hashing**

The generator defaults to **bcrypt** for Unix and **pbkdf2** for Windows to securely hash passwords. You can change the hashing library with the `--hashing-lib` option:

```bash
mix phx.gen.auth Accounts User users --hashing-lib argon2
```

- **Supported Libraries**:
  - **bcrypt**: Light on CPU resources.
  - **pbkdf2**: Compatible with many platforms, lightweight.
  - **argon2**: The most secure, but more resource-intensive.

For more on hashing libraries, see the [Comeonin library documentation](https://hexdocs.pm/comeonin/).

### 2. **Access Controls and Plugs**

An authentication module (`YourAppWeb.UserAuth`) is created with helper functions called **plugs**. Some key plugs are:

- **`fetch_current_user`**: Retrieves user information if available.
- **`require_authenticated_user`**: Ensures a user is logged in before accessing certain routes.
- **`redirect_if_user_is_authenticated`**: Redirects logged-in users from routes meant for non-authenticated users (like a login page).

### 3. **Account Confirmation**

A **confirmation mechanism** is included, allowing you to confirm users (e.g., via email) before they access certain features. However, this is not enforced by default. To enforce it, modify `require_authenticated_user` to check for a `confirmed_at` field or other verification conditions.

### 4. **Notifiers for Email/SMS**

No actual email or SMS system is integrated by default. The generator logs messages to the terminal instead. If you want email confirmation, integrate a tool like [Swoosh](https://hexdocs.pm/swoosh/Swoosh.html) to send actual emails during development or production. You can view emails in development at `/dev/mailbox`.

### 5. **Session and Token Management**

User sessions and tokens are stored in a dedicated table, allowing you to track active sessions. If a password is changed or reset, all tokens are invalidated, forcing users to re-authenticate.

### 6. **User Enumeration Protection**

The generated code does not fully protect against user enumeration attacks (where someone checks if an email is registered). To add security, you’ll need custom error messages and workflows, balancing user experience with security.

### 7. **Case-Insensitive Email Lookups**

The system performs **case-insensitive email lookups** by default, essential for standardizing email entries. This is implemented using:

- **`COLLATE NOCASE`** for SQLite.
- **`citext` extension** for PostgreSQL.

If `citext` is missing in PostgreSQL, install it (often included in `postgres-contrib`).

## **Testing and Concurrent Tests**

The generated tests run concurrently with databases that support it, like PostgreSQL. This is efficient and speeds up testing by running multiple tests in parallel.

## **Advanced Options and Additional Resources**

For further customization, `mix phx.gen.auth` offers options for changing the hashing library, customizing namespaces, and using binary IDs or custom table names.
