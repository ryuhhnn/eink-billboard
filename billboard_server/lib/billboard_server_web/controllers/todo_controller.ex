# TODO(ryuhhnn): be able to mark todos as done but still display
defmodule BillboardServerWeb.TodoController do
  use BillboardServerWeb, :controller

  def read(conn, %{"token" => token}) do
    todos = CubDB.get(BillboardServer.CubDB, :todos) |> Map.get(token)

    json(conn, %{todos: todos || []})
  end

  def save(conn, %{"todos" => new_todo, "token" => token}) do
    unless !token do
      case(
        CubDB.get_and_update(
          BillboardServer.CubDB,
          :todos,
          fn
            nil -> {:ok, Map.put(%{}, token, new_todo)}
            todos -> {:ok, Map.put(todos, token, (Map.get(todos, token) || []) ++ new_todo)}
          end
        )
      ) do
        :ok ->
          todos = CubDB.get(BillboardServer.CubDB, :todos) |> Map.get(token)
          json(conn, %{todos: todos})

        _ ->
          json(conn, %{error: "true"})
      end
    end
  end

  # TODO(ryuhhnn): delete only one todo
  def drop(conn, _params) do
    CubDB.delete(BillboardServer.CubDB, :todos)

    json(conn, %{success: "true"})
  end
end
