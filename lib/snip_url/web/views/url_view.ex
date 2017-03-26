defmodule SnipUrl.Web.UrlView do
  use SnipUrl.Web, :view
  alias SnipUrl.Web.UrlView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, UrlView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, UrlView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{id: url.id,
      original_url: url.original_url,
      snip_url: url.snip_url}
  end
end
