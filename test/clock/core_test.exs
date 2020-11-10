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
           |> String.match?(~r/^(1[0-2]|0?[1-9]):([0-5]?[0-9])(\s[AP]M)$/)
  end

  test "duration_minutes" do
    assert %Timex.Duration{} = Core.duration_minutes(5)
  end

  test "add" do
    time = Core.current_time()
    duration = Core.duration_minutes(5)
    new_time = Core.add(time, duration)

    assert 5 = Core.diff_minutes(new_time, time)
  end
end
