defmodule SnipUrl.Web.HomeController do
  use SnipUrl.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
