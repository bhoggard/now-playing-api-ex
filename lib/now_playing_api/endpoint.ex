defmodule NowPlayingApi.Endpoint do
  @moduledoc """
  A Plug responsible for logging request info,
  matching routes, and dispatching responses.
  """

  alias NowPlayingApi.FeedService
  use Plug.Router

  # Using Plug.Logger for logging request information
  plug(Plug.Logger)
  # responsible for matching routes
  plug(:match)
  # Using Poison for JSON decoding
  # Note, order of plugs is important, by placing this _after_ the 'match' plug,
  # we will only parse the request AFTER there is a route match.
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  # responsible for dispatching responses
  plug(:dispatch)

  # A simple route to test that the server is up
  # Note, all routes must return a connection as per the Plug spec.
  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  get "/api/counterstream" do
    send_json(conn, FeedService.counterstream)
  end

  get "/api/dronezone" do
    send_json(conn, FeedService.dronezone)
  end

  get "/api/q2" do
    send_json(conn, FeedService.q2)
  end

  get "/api/yle" do
    send_json(conn, FeedService.yle)
  end

  # A catchall route, 'match' will match no matter the request method,
  # so a response is always returned, even if there is no route to match.
  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  defp send_json(conn, response_data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response_data))
  end
end
