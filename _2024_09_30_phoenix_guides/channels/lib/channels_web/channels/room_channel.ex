defmodule ChannelsWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def recursion(socket) do
    :timer.sleep(10000)
    push(socket, "new_msg", %{"body" => "recursion"})
    recursion(socket)
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    recursion(socket)
    {:noreply, socket}
  end
end
