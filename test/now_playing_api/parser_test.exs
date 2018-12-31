defmodule NowPlayingApi.ParserTest do
  use ExUnit.Case, async: true
  alias NowPlayingApi.Parser

  test "parsing dronezone XML" do
    xml = "
<event>
<event_version>1.0</event_version>
<artist>Forrest Fang</artist>
<title>Henon's Aurora</title>
<duration>180000</duration>
<eventcategory>MUS</eventcategory>
<eventid>0000</eventid>
</event>
    "

    %{ title: title, composer: composer } = Parser.parse_somafm(xml)
    assert title == "Henon's Aurora"
    assert composer == "Forrest Fang"
  end

  test "parsing Q2 json" do
    {:ok, text} = File.read("test/data/q2.json")
    %{ title: title, composer: composer } = Parser.parse_q2(text)
    assert title == "For 2 Akis"
    assert composer == "Shinya Fukumori"
  end

  test "parsing WKCR XML" do
    {:ok, text} = File.read("test/data/wkcr.xml")
    %{ title: title, composer: composer } = Parser.parse_wkcr(text)
    assert title == "Arlene Auger, Julia Hamari, Lutz-Michael Harder, Philippe Huttenlicher, and Helmuth Rilling: 'Cantata BWV 43: \"Gott fahret auf mit Jauchzen\"'"
    assert composer == ""
  end

  test "parsing YLE json" do
    {:ok, text} = File.read("test/data/yle.xml")
    %{ title: title, composer: composer } = Parser.parse_yle(text)
    assert title == "Rigoletto 3-näytöksinen ooppera (kokonaisesitys).  "
    assert composer == "Verdi, Giuseppe [1813-1901]"
  end
end
