defmodule Clock do
  alias Clock.{Server, Core}

  def start_link(tick_seconds: tick_seconds) when is_integer(tick_seconds) do
    Server.start_link(tick_seconds: tick_seconds)
  end

  def time(clock) when is_pid(clock) do
    clock
    |> GenServer.call(:state)
    |> Map.get(:time)
    |> Core.format_time()
  end

  def tick(clock) when is_pid(clock) do
    send(clock, :tick)
  end
end
