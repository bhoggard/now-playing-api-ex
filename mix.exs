defmodule NowPlayingApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :now_playing_api,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {NowPlayingApi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 4.0"},
      {:plug_cowboy, "~> 2.0"},
      {:exml, "~> 0.1.1"},
      {:cors_plug, "~> 2.0"},
      {:music_feed, "~> 0.9.0"}
    ]
  end
end
