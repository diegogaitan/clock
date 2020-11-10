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

  def add_minutes(%DateTime{} = time, minutes) when is_integer(minutes) do
    duration = duration_minutes(minutes)
    Timex.add(time, duration)
  end

  def diff_minutes(%DateTime{} = time1, %DateTime{} = time2) do
    Timex.diff(time1, time2, :minute)
  end

  def format_time_regex do
    ~r/^(1[0-2]|0?[1-9]):([0-5]?[0-9])(\s[AP]M)$/
  end
end
