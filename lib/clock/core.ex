defmodule Clock.Core do
  use Timex

  def format_time(time) do
    {:ok, now} = Timex.format(time, "{h12}:{m} {AM}")
    now
  end

  def current_time(time_zone \\ "America/Bogota") do
    time_zone |> Timex.now()
  end

  def duration_minutes(minutes) when is_integer(minutes) do
    Timex.Duration.from_minutes(minutes)
  end

  def add(%DateTime{} = time, %Timex.Duration{} = duration) do
    Timex.add(time, duration)
  end

  def diff_minutes(%DateTime{} = time1, %DateTime{} = time2) do
    Timex.diff(time1, time2, :minute)
  end
end
