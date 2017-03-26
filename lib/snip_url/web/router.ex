defmodule SnipUrl.Web.Router do
  use SnipUrl.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SnipUrl.Web do
    pipe_through :browser # Use the default browser stack

    get "/", HomeController, :index
  end

  scope "/api", SnipUrl.Web, as: :api do
    pipe_through :api

    resources "/urls", UrlController, except: [:new, :edit]
  end
end
