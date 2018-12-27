defmodule NowPlayingApi.FeedService do
  @moduledoc """
  Service module which receives requests from the API Endpoint
  """

  require Logger
  
  def counterstream do
    {:ok, {{'HTTP/1.0', 200, 'OK'}, _headers, body }} = 
      :httpc.request('http://counterstream.newmusicusa.org:8000/currentsong?sid=1')
    Logger.info(body)
    %{title: "Title", composer: "Composer"}
  end
end

# {:ok, {{'HTTP/1.0', 200, 'OK'}, [{'content-length', '24'}, {'content-type', 'text/plain;charset=utf-8'}], 'David Lang - How to Pray'}}
