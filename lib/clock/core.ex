defmodule Clock.Core do
  use Timex

  @time_format "{h12}:{m}:{s} {AM}"

  def format_time(time) do
    {:ok, now} = Timex.format(time, @time_format)
    now
  end

  def current_time(time_zone \\ "America/Bogota") do
    time_zone |> Timex.now()
  end

  def duration_seconds(seconds) when is_integer(seconds) do
    Timex.Duration.from_seconds(seconds)
  end

  def add_seconds(%DateTime{} = time, seconds) when is_integer(seconds) do
    duration = duration_seconds(seconds)
    Timex.add(time, duration)
  end

  def diff_seconds(%DateTime{} = time1, %DateTime{} = time2) do
    Timex.diff(time1, time2, :seconds)
  end

  # Regex for this time format 7:56 AM
  # Based on this article: https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/ch04s06.html
  def format_time_regex do
    ~r/^(1[0-2]|0?[1-9]):([0-5]?[0-9]):([0-5]?[0-9])(\s[AP]M)$/
  end

  def parse(time_str) when is_binary(time_str) do
    {:ok, naive_datetime} = Timex.parse(time_str, @time_format)
    Timex.to_datetime(naive_datetime)
  end
end
