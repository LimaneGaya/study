## Phoenix Presence

Phoenix Presence lets you track which users are online and what they're doing in your application. It's like a live roster that updates automatically. Like a chat app showing who's currently typing – that's a use case for Presence.

### 1. Generating the Presence Module

First, create a Presence module:

```bash
mix phx.gen.presence
```

This creates `lib/hello_web/channels/presence.ex`. Add this module to your supervision tree in `lib/hello/application.ex`:

```elixir
children = [
  ...
  HelloWeb.Presence,
]
```

Inside `lib/hello_web/channels/presence.ex`, you'll see:

```elixir
use Phoenix.Presence,
  otp_app: :hello,
  pubsub_server: Hello.PubSub
```

This configures your Presence module. The `otp_app` is your application name and `pubsub_server` handles the real-time communication.


### 2. Integrating Presence with Channels

Now, let's update the `RoomChannel` to use Presence. When a user joins the channel, we'll track their presence and broadcast the current online list.

```elixir
defmodule HelloWeb.RoomChannel do
  use Phoenix.Channel
  alias HelloWeb.Presence

  def join("room:lobby", %{"name" => name}, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, :name, name)}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} =
      Presence.track(socket, socket.assigns.name, %{
        online_at: inspect(System.system_time(:second)) # Example metadata
      })

    push(socket, "presence_state", Presence.list(socket)) # Send initial presence list
    {:noreply, socket}
  end

  # ... other channel functions
end

```

Here's what's happening:

* **`Presence.track(socket, socket.assigns.name, %{ online_at: ... })`**: This registers the user's presence. The first argument is the socket, the second is a unique identifier (we're using the name here, but ideally, it should be a user ID), and the third is metadata about the presence (like when they joined).
* **`Presence.list(socket)`**: Gets the current list of presences on the channel.
* **`push(socket, "presence_state", Presence.list(socket))`**: Sends the presence list to the client over the "presence_state" event.


### 3. Dart Client with `phoenix_socket_dart`

Let's build the Dart client using the `phoenix_socket_dart` package. Make sure you've added it to your `pubspec.yaml`.

```dart
import 'package:phoenix_socket/phoenix_socket.dart';

// Replace with your actual socket URL and token if needed
final socket = PhoenixSocket('ws://localhost:4000/socket'); 
final channel = socket.channel('room:lobby', {'name': 'Alice'}); // User's name
final presence = PhoenixPresence(channel);

void main() async {
  await socket.connect();

  presence.onSync.listen((_) {
    print('Presence updated!');
    final onlineUsers = presence.list();
    onlineUsers.forEach((key, presenceData) {
      print('User: $key, Metas: ${presenceData.metas}');
    });
  });

  channel.join();
}

```

Here's the breakdown:

* **`PhoenixSocket('ws://localhost:4000/socket')`**: Creates a socket connection to your Phoenix server.
* **`socket.channel('room:lobby', {'name': 'Alice'})`**: Joins the "room:lobby" channel, providing the user's name.
* **`PhoenixPresence(channel)`**: Creates a Presence object for the channel.
* **`presence.onSync.listen((_) { ... })`**: This callback fires whenever the presence state changes (user joins, leaves, or updates metadata). Inside the callback, we use `presence.list()` to get the updated list of presences.


### 4. Security Considerations

Using the user's name directly from the URL is insecure. Implement proper authentication (like token-based authentication) to verify user identity and prevent unauthorized access to presence functionality. See the Phoenix Channels guide for details on token authentication.

### 5. Further Enhancements

* **More Meaningful Metadata:** Instead of just `online_at`, you can store more useful information like the user's current status (e.g., "typing", "away"), game score, or location.
* **Presence Diffs:**  For larger applications, use presence diffs (`presence_diff` events) to send only the changes in presence state, reducing bandwidth usage. The `phoenix_socket_dart` package handles diffs automatically.
