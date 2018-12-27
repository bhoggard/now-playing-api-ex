defmodule NowPlayingApi.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts NowPlayingApi.Endpoint.init([])

  test "it returns pong" do
    # Create a test connection
    conn = conn(:get, "/ping")

    # Invoke the plug
    conn = NowPlayingApi.Endpoint.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong!"
  end
end
