defmodule Clock.Server do
  use GenServer
  alias Clock.Core

  def start_link(tick_seconds: tick_seconds) when is_integer(tick_seconds) do
    GenServer.start_link(__MODULE__, tick_seconds)
  end

  def init(tick_seconds) when is_integer(tick_seconds) do
    initial_state =
      %{tick_seconds: tick_seconds, time: Core.current_time()}

    schedule_tick(tick_seconds)
    {:ok, initial_state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:tick, %{tick_seconds: tick_seconds, time: time} = state) do
    new_state =
      %{state | time: Core.add_seconds(time, tick_seconds)}

    schedule_tick(tick_seconds)
    {:noreply, new_state}
  end

  defp schedule_tick(tick_seconds) when is_integer(tick_seconds)  do
    Process.send_after(self(), :tick, tick_seconds * 1000)
  end
end
