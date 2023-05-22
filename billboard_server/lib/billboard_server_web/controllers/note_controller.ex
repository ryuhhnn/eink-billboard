defmodule BillboardServerWeb.NoteController do
  use BillboardServerWeb, :controller

  def read(conn, %{"token" => token}) do
    unless !token do
      notes = CubDB.get(BillboardServer.CubDB, :notes)
      note = Map.get(notes || %{}, token)

      json(conn, %{body: note || ""})
    end

    # TODO(ryuhhnn): move this to plug
    json(conn, %{error: "must supply token"})
  end

  def save(conn, %{"body" => new_note, "token" => token}) do
    unless !token do
      case(
        CubDB.get_and_update(
          BillboardServer.CubDB,
          :notes,
          fn
            nil -> {:ok, Map.put(%{}, token, new_note)}
            notes -> {:ok, Map.put(notes, token, new_note)}
          end
        )
      ) do
        :ok ->
          json(conn, %{body: new_note})

        _ ->
          json(conn, %{error: "true"})
      end
    end

    # TODO(ryuhhnn): move this to plug
    json(conn, %{error: "must supply token"})
  end

  def drop(conn, _params) do
    case(CubDB.delete(BillboardServer.CubDB, :notes)) do
      :ok ->
        json(conn, %{success: "true"})

      _ ->
        json(conn, %{error: "true"})
    end
  end
end
