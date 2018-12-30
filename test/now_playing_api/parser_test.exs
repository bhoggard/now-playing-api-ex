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
end
