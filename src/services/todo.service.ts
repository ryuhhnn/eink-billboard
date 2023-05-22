import { API_BASE, TOKEN } from "../constants";

class TodoService {
  static async fetch() {
    try {
      const response = await fetch(`${API_BASE}/todos/read${TOKEN}`);
      const payload = await response.json();

      return payload.todos;
    } catch (e) {
      console.error("Error fetching: ", e);
    }
  }

  static async save(newTodo: string) {
    try {
      const response = await fetch(`${API_BASE}/todos/save${TOKEN}`, {
        method: "POST",
        mode: "cors",
        cache: "no-cache",
        credentials: "same-origin",
        headers: {
          "Content-Type": "application/json",
        },
        redirect: "follow",
        referrerPolicy: "no-referrer",
        body: JSON.stringify({ todos: [newTodo] }),
      });

      if (!response.ok) {
        throw new Error();
      } else {
        const payload = await response.json();
        return [true, payload.todos];
      }
    } catch (e) {
      console.error("Error saving todo: ", e);
    }
  }
}

export default TodoService;
