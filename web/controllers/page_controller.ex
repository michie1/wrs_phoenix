defmodule WrsPhoenix.PageController do
  use WrsPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
