defmodule NowPlayingApi.FeedService do
  @moduledoc """
  Service module which receives requests from the API Endpoint
  and returns maps with keys :title and :composer
  """

  require Logger
  alias MusicFeed.Parser
  
  def counterstream do
    [composer, title] = 
      load_url('http://counterstream.newmusicusa.org:8000/currentsong?sid=1')
      |> String.split(" - ")
    %{title: title, composer: composer}
  end

  def dronezone do
    load_url('http://api.somafm.com/recent/dronezone.tre.xml')
    |> Parser.parse_somafm
  end

  def q2 do
    load_url('https://api.wnyc.org/api/v1/whats_on/q2/')
    |> Parser.parse_q2
  end

  def wkcr do
    load_url('https://spinitron.com/radio/rss.php?station=wkcr')
    |> Parser.parse_wkcr
  end

  def yle do
    load_url('https://yle.fi/radiomanint/LiveXML/r17/item(0).xml')
    |> Parser.parse_yle
  end

  defp load_url(url) do
    {:ok, {{_http, 200, 'OK'}, _headers, body }} = 
      :httpc.request(url)

    body
    |> IO.iodata_to_binary
  end
end

