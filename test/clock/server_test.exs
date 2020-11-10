defmodule Core.ServerTest do
  use ExUnit.Case
  alias Clock.Server
  alias Clock.Core

  @tick_seconds 1

  setup do
    server = start_supervised!({Server, tick_seconds: @tick_seconds})
    %{:server => server}
  end

  test "state", %{:server => server} do
    server
    |> get_time()
    |> assert_formatted_time()
  end

  test "tick", %{:server => server} do
    send(server, :tick)

    start_time = get_time(server)
    assert_formatted_time(start_time)

    Process.sleep(@tick_seconds * 1000)

    end_time = get_time(server)
    assert_formatted_time(end_time)

    assert Core.diff_seconds(end_time, start_time) >= @tick_seconds
  end

  defp get_time(server) when is_pid(server) do
    GenServer.call(server, :state) |> Map.get(:time)
  end

  defp assert_formatted_time(time) do
    assert time
           |> Core.format_time()
           |> String.match?(Core.format_time_regex())
  end
end
