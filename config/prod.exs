use Mix.Config

port =
case System.get_env("PORT") do
  port when is_binary(port) -> String.to_integer(port)
  nil -> 80 # default port
end

config :now_playing_api, port: port

config :now_playing_api, NowPlayingApi.Endpoint,
  http: [port: {:system, "PORT"}], # Possibly not needed, but doesn't hurt
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443],
  server: true
