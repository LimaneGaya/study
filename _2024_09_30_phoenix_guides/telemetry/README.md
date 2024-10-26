## Telemetry in Phoenix

Telemetry is like a flight data recorder for your application. It records important events happening inside your app and allows you to analyze this data to understand how your app is performing and identify potential issues.

**Core Concepts:**

1. **Events:**  Specific moments in your application's lifecycle, like a web request starting or a database query finishing. Each event has a name (e.g., "phoenix.endpoint.stop"), measurements (e.g., duration), and metadata (e.g., the route being accessed).
2. **Metrics:**  Aggregations of Telemetry events, providing insights over time. For example, you might track the average duration of web requests or the number of database queries per minute.
3. **Reporters:** Tools that listen for Telemetry events, aggregate them into metrics, and send them to a destination (e.g., your terminal, a monitoring dashboard).

**Setting up Telemetry in Phoenix:**

Phoenix applications are generated with a Telemetry supervisor, which manages the lifecycle of your Telemetry processes. It defines the metrics you want to track and starts reporters to handle them.

**1. Dependencies (If upgrading from older Phoenix):**

```elixir
{:telemetry_metrics, "~> 1.0"},
{:telemetry_poller, "~> 1.0"}
```

**2. Create the Telemetry Supervisor:**

```elixir
# lib/my_app_web/telemetry.ex
defmodule MyAppWeb.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  # ... (rest of the code is explained below)
end
```

**3. Add it to your application's supervision tree:**

```elixir
# lib/my_app/application.ex
children = [
  MyAppWeb.Telemetry,
  # ... other processes
]
```

**Understanding the Telemetry Supervisor:**

The `MyAppWeb.Telemetry` module contains:

- `start_link/1`: Starts the supervisor.
- `init/1`: Defines the children processes, including reporters and the `:telemetry_poller`.
- `metrics/0`:  Defines the metrics you want to track using `Telemetry.Metrics` functions.
- `periodic_measurements/0`: Defines custom measurements to be taken at intervals using `:telemetry_poller`.

**Defining Metrics:**

The `metrics/0` function uses `Telemetry.Metrics` functions to define how to structure Telemetry events into specific metric types:

- `counter/2`: Counts the number of times an event occurs.
- `last_value/2`:  Records the last value of a measurement.
- `summary/2`: Calculates statistics like average, minimum, maximum, and percentiles.
- `distribution/2`: Creates histograms to visualize the distribution of values.

**Example:**

```elixir
# lib/my_app_web/telemetry.ex
def metrics do
  [
    summary("phoenix.endpoint.stop.duration", unit: {:native, :millisecond}), # Tracks web request duration
    counter("my_app.user.signup") # Counts user signups
  ]
end
```

**Using Reporters:**

Reporters listen for events defined in `metrics/0` and handle them according to the specified metric type.

- **ConsoleReporter:** Prints events and metrics to your terminal for debugging and experimentation.

```elixir
# lib/my_app_web/telemetry.ex
children = [
  # ...
  {Telemetry.Metrics.ConsoleReporter, metrics: metrics()}
]
```

- **LiveDashboard:** Provides real-time visualizations of your metrics in a beautiful dashboard.

**Custom Events:**

You can instrument your own code to emit custom Telemetry events:

```elixir
:telemetry.execute([:my_app, :user, :login], %{duration: time_taken}, %{user_id: user.id}) 
```

This emits an event named "my_app.user.login" with the duration of the login process and the user's ID.

**Tips and Tricks:**

- **Tagging:** Use the `:tags` and `:tag_values` options in `Telemetry.Metrics` functions to group and categorize your metrics (e.g., by route, HTTP method).
- **Periodic Measurements:** Use `:telemetry_poller` to collect data at regular intervals, such as process memory usage or queue lengths.
- **Exploring Existing Events:** Many libraries, including Phoenix and Ecto, already emit Telemetry events. Check their documentation to see what's available.

**Conclusion:**

Telemetry is a powerful tool for understanding and improving your Phoenix application's performance. By defining meaningful metrics and using appropriate reporters, you can gain valuable insights into your app's behavior and identify areas for optimization.
