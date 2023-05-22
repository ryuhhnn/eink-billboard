const urlParams = new URLSearchParams(window.location.search);

export const API_BASE = "http://localhost:4000/api";
export const TOKEN = `?token=${urlParams.get("token")}`;
