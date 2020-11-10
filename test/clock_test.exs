defmodule ClockTest do
  alias Clock.Core
  use ExUnit.Case

  @tick_seconds 1

  setup do
    clock =
      start_supervised!(%{
        id: Clock,
        start: {Clock, :start_link, [[tick_seconds: @tick_seconds]]}
      })

    %{:clock => clock}
  end

  test "time", %{clock: clock} do
    assert clock
           |> Clock.time()
           |> String.match?(Core.format_time_regex())
  end

  test "tick", %{clock: clock} do
    start_time = Clock.time(clock) |> Core.parse()
    Clock.tick(clock)
    Process.sleep(@tick_seconds)
    end_time = Clock.time(clock) |> Core.parse()

    assert Core.diff_seconds(end_time, start_time) >= @tick_seconds
  end
end
