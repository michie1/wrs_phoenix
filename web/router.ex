defmodule WrsPhoenix.Router do
  use WrsPhoenix.Web, :router

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

  scope "/", WrsPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    resources "/riders", RiderController
    resources "/races", RaceController
    resources "/results", ResultController
    resources "/posts", CommentController
    resources "/comments", CommentController
  end

  # Other scopes may use custom stacks.
  # scope "/api", WrsPhoenix do
  #   pipe_through :api
  # end
end
