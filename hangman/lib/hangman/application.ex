defmodule Hangman.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Hangman.Server, []},
    ]

    opts = [strategy: :simple_one_for_one, name: Hangman.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
