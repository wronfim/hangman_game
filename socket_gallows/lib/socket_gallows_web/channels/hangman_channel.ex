defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel

  def join("hangman:game", _args, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    {:ok, socket}
  end

  def handle_in("tally", _args, socket) do
    tally = socket.assigns.game |> Hangman.tally()
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in("new_game", _args, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    handle_in("tally", nil, socket)
  end
end