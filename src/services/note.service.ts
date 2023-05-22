import { API_BASE, TOKEN } from "../constants";

class NoteService {
  static async fetch() {
    try {
      const response = await fetch(`${API_BASE}/note/read${TOKEN}`);
      const payload = await response.json();

      return payload;
    } catch (e) {
      console.error("Error fetching: ", e);
    }
  }

  static async save(newNote: string) {
    try {
      const response = await fetch(`${API_BASE}/note/save${TOKEN}`, {
        method: "POST",
        mode: "cors",
        cache: "no-cache",
        credentials: "same-origin",
        headers: {
          "Content-Type": "application/json",
        },
        redirect: "follow",
        referrerPolicy: "no-referrer",
        body: JSON.stringify({ body: newNote }),
      });

      if (!response.ok) {
        throw new Error();
      } else {
        const payload = await response.json();
        return [true, payload];
      }
    } catch (e) {
      console.error("Error saving note: ", e);
    }
  }
}

export default NoteService;
