defmodule BillboardServerWeb.Router do
  use BillboardServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BillboardServerWeb do
    pipe_through(:api)

    scope "/client" do
      get("/register", ClientController, :register)
    end

    scope "/note" do
      get("/read", NoteController, :read)
      post("/save", NoteController, :save)
    end

    scope "/todos" do
      get("/read", TodoController, :read)
      post("/save", TodoController, :save)
    end
  end

  # TODO(ryuhhnn): DEV ROUTES
  scope "/api", BillboardServerWeb do
    pipe_through(:api)

    scope "/client" do
      get("/drop", ClientController, :drop)
      get("/list", ClientController, :list)
    end

    scope "/note" do
      get("/drop", NoteController, :drop)
    end

    scope "/todos" do
      get("/drop", TodoController, :drop)
    end
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:billboard_server, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: BillboardServerWeb.Telemetry)
    end
  end
end
