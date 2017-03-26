defmodule SnipUrl.ShortnerTest do
  use SnipUrl.DataCase

  alias SnipUrl.Shortner
  alias SnipUrl.Shortner.Url

  @create_attrs %{original_url: "some original_url", snip_url: "some snip_url"}
  @update_attrs %{original_url: "some updated original_url", snip_url: "some updated snip_url"}
  @invalid_attrs %{original_url: nil, snip_url: nil}

  def fixture(:url, attrs \\ @create_attrs) do
    {:ok, url} = Shortner.create_url(attrs)
    url
  end

  test "list_urls/1 returns all urls" do
    url = fixture(:url)
    assert Shortner.list_urls() == [url]
  end

  test "get_url! returns the url with given id" do
    url = fixture(:url)
    assert Shortner.get_url!(url.id) == url
  end

  test "create_url/1 with valid data creates a url" do
    assert {:ok, %Url{} = url} = Shortner.create_url(@create_attrs)
    assert url.original_url == "some original_url"
    assert url.snip_url == "some snip_url"
  end

  test "create_url/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Shortner.create_url(@invalid_attrs)
  end

  test "update_url/2 with valid data updates the url" do
    url = fixture(:url)
    assert {:ok, url} = Shortner.update_url(url, @update_attrs)
    assert %Url{} = url
    assert url.original_url == "some updated original_url"
    assert url.snip_url == "some updated snip_url"
  end

  test "update_url/2 with invalid data returns error changeset" do
    url = fixture(:url)
    assert {:error, %Ecto.Changeset{}} = Shortner.update_url(url, @invalid_attrs)
    assert url == Shortner.get_url!(url.id)
  end

  test "delete_url/1 deletes the url" do
    url = fixture(:url)
    assert {:ok, %Url{}} = Shortner.delete_url(url)
    assert_raise Ecto.NoResultsError, fn -> Shortner.get_url!(url.id) end
  end

  test "change_url/1 returns a url changeset" do
    url = fixture(:url)
    assert %Ecto.Changeset{} = Shortner.change_url(url)
  end
end
