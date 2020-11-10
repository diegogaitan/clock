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

  test "duration_seconds" do
    assert %Timex.Duration{} = Core.duration_seconds(5)
  end

  test "add_seconds" do
    time = Core.current_time()
    new_time = Core.add_seconds(time, 5)

    assert 5 = Core.diff_seconds(new_time, time)
  end

  test "parse" do
    assert %DateTime{} = Core.parse("8:25:56 AM")
  end
end
