defmodule DumenuffInterface.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    dir = Application.app_dir(:dumenuff_bots) <> "/priv/node"
    IO.inspect(dir, label: "application / dir")

    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      DumenuffInterfaceWeb.Endpoint,
      # Starts a worker by calling: DumenuffInterface.Worker.start_link(arg)
      # {DumenuffInterface.Worker, arg},
      %{
        id: NodeJS,
        start: {
          NodeJS,
          :start_link,
          #[[path: "apps/dumenuff_bots/priv/node", pool_size: 4]]
          [[path: dir, pool_size: 4]]
        }
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DumenuffInterface.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DumenuffInterfaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
