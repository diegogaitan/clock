defmodule Clock.Core do
  use Timex

  def current_time do
    {:ok, now} =
      "America/Bogota"
      |> Timex.now()
      |> Timex.format("{h12}:{m} {AM}")

    now
  end
end
