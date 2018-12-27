defmodule NowPlayingApi.FeedService do
  @moduledoc """
  Service module which receives requests from the API Endpoint
  and returns maps with keys :title and :composer
  """

  require Logger
  
  def counterstream do
    {:ok, {{'HTTP/1.0', 200, 'OK'}, _headers, body }} = 
      :httpc.request('http://counterstream.newmusicusa.org:8000/currentsong?sid=1')
    
    [composer, title] = body
      |> to_string
      |> String.split(" - ")
    %{title: title, composer: composer}
  end
end

