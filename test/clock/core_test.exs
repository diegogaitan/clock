defmodule Clock.CoreTest do
  use ExUnit.Case
  alias Clock.Core

  test "current_time" do
    assert %DateTime{} = Core.current_time()
  end

  test "format_time" do
    # Matches this time format: 7:25 PM"
    assert Core.current_time()
           |> Core.format_time()
           |> String.match?(Core.format_time_regex())
  end

  test "duration_minutes" do
    assert %Timex.Duration{} = Core.duration_minutes(5)
  end

  test "add_minutes" do
    time = Core.current_time()
    new_time = Core.add_minutes(time, 5)

    assert 5 = Core.diff_minutes(new_time, time)
  end
end
