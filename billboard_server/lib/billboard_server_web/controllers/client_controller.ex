defmodule BillboardServerWeb.ClientController do
  use BillboardServerWeb, :controller

  def register(conn, _params) do
    new_client =
      :crypto.strong_rand_bytes(22)
      |> Base.url_encode64()
      |> binary_part(0, 22)

    case(
      CubDB.get_and_update(
        BillboardServer.CubDB,
        :clients,
        fn
          nil -> {:ok, [new_client]}
          clients -> {:ok, clients ++ [new_client]}
        end
      )
    ) do
      :ok ->
        json(conn, %{client_token: new_client})

      _ ->
        json(conn, %{error: "true"})
    end
  end

  def drop(conn, _params) do
    case(CubDB.delete(BillboardServer.CubDB, :clients)) do
      :ok ->
        json(conn, %{success: "true"})

      _ ->
        json(conn, %{error: "true"})
    end
  end

  def list(conn, _params) do
    clients = CubDB.get(BillboardServer.CubDB, :clients)

    json(conn, %{clients: clients})
  end
end
