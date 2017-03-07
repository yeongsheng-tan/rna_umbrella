defmodule Rna.Web.PageController do
  use Rna.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
