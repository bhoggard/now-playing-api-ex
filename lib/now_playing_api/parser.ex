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

  def parse_wkcr(text) do
    doc = Exml.parse(text)
    title = Exml.get doc, "//channel/item[1]/title"
    %{title: title, composer: ""}
  end

  def parse_yle(text) do
    doc = Exml.parse(text)
    title = Exml.get doc, "//RMPADEXPORT/ITEM/@TITLE"
    roles_list = Exml.get doc, "//RMPADEXPORT/ITEM/ROLES/ROLE"
    [_role, composer] = Enum.find(roles_list, fn(i) -> Enum.fetch(i,0) == {:ok, "COMPOSER"} end)
    %{title: title, composer: composer}
  end
end
