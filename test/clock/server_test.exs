defmodule Core.ServerTest do
  use ExUnit.Case
  alias Clock.Server
  alias Clock.Core

  setup do
    server = start_supervised!({Server, Core.current_time()})
    %{:server => server}
  end

  test "state", %{:server => server} do
    assert_state(server)
  end

  test "tick", %{:server => server} do
    send(server, :tick)
    assert_state(server)
  end

  defp assert_state(server) when is_pid(server) do
    formatted_time =
      GenServer.call(server, :state) 
      |> Core.format_time()

    assert String.match?(formatted_time, Core.format_time_regex())
  end
end
