defmodule SnipUrl.Web.UrlControllerTest do
  use SnipUrl.Web.ConnCase

  alias SnipUrl.Shortner
  alias SnipUrl.Shortner.Url

  @create_attrs %{original_url: "some original_url", snip_url: "some snip_url"}
  @update_attrs %{original_url: "some updated original_url", snip_url: "some updated snip_url"}
  @invalid_attrs %{original_url: nil, snip_url: nil}

  def fixture(:url) do
    {:ok, url} = Shortner.create_url(@create_attrs)
    url
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_url_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates url and renders url when data is valid", %{conn: conn} do
    conn = post conn, api_url_path(conn, :create), url: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, api_url_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "original_url" => "some original_url",
      "snip_url" => "some snip_url"}
  end

  test "does not create url and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_url_path(conn, :create), url: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen url and renders url when data is valid", %{conn: conn} do
    %Url{id: id} = url = fixture(:url)
    conn = put conn, api_url_path(conn, :update, url), url: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, api_url_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "original_url" => "some updated original_url",
      "snip_url" => "some updated snip_url"}
  end

  test "does not update chosen url and renders errors when data is invalid", %{conn: conn} do
    url = fixture(:url)
    conn = put conn, api_url_path(conn, :update, url), url: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen url", %{conn: conn} do
    url = fixture(:url)
    conn = delete conn, api_url_path(conn, :delete, url)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, api_url_path(conn, :show, url)
    end
  end
end
