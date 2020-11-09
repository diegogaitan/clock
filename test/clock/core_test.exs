defmodule Clock.CoreTest do
  use ExUnit.Case

  test "current_time" do
    # Matches this time format: 7:25 PM"
    assert Clock.Core.current_time()
           |> String.match?(~r/^(1[0-2]|0?[1-9]):([0-5]?[0-9])(\s[AP]M)$/)
  end
end
