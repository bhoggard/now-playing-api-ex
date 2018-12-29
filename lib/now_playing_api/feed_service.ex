defmodule NowPlayingApi.FeedService do
  @moduledoc """
  Service module which receives requests from the API Endpoint
  and returns maps with keys :title and :composer
  """

  require Logger
  
  def counterstream do
    [composer, title] = 
      load_url('http://counterstream.newmusicusa.org:8000/currentsong?sid=1')
      |> String.split(" - ")
    %{title: title, composer: composer}
  end

  defp load_url(url) do
    {:ok, {{'HTTP/1.0', 200, 'OK'}, _headers, body }} = 
      :httpc.request(url)
    to_string(body)
  end
end

