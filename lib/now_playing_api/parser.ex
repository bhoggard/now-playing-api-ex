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

  def parse_q2(text) do
    {:ok, json} = Poison.decode(text)
    entry = json["current_playlist_item"]["catalog_entry"]
    %{title: entry["title"], composer: entry["composer"]["name"]}
  end

  def parse_yle(text) do
    doc = Exml.parse(text)
    title = Exml.get doc, "//RMPADEXPORT/ITEM/@TITLE"
    [_role, composer] = Exml.get doc, "//RMPADEXPORT/ITEM/ROLES/ROLE[1]"
    %{title: title, composer: composer}
  end
end
