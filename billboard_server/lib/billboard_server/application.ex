defmodule BillboardServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BillboardServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BillboardServer.PubSub},
      # Start the Endpoint (http/https)
      BillboardServerWeb.Endpoint,
      # Start a worker by calling: BillboardServer.Worker.start_link(arg)
      # {BillboardServer.Worker, arg}
      {CubDB,
       [
         data_dir: "/Users/ryancoleman/Workspace/eink-billboard/billboard_server/data",
         name: BillboardServer.CubDB
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BillboardServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BillboardServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
