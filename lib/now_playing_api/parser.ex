defmodule NowPlayingApi.Parser do
  @moduledoc """
  Parsers for XML or JSON data about streaming music services
  """
  
  def parse_somafm(text) do
    doc = Exml.parse(text)
    title = Exml.get doc, "//event//title"
    artist = Exml.get doc, "//event//artist"
    %{title: title, composer: artist}
  end
end
