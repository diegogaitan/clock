defmodule Clock.Server do
  use GenServer
  alias Clock.Core

  @tick_period 1  # 1 minute

  def start_link(%DateTime{} = initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def init(%DateTime{} = initial_state) do
    schedule_tick()
    {:ok, initial_state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:tick, state) do
    new_state = Core.add_minutes(state, @tick_period)
    schedule_tick()
    {:noreply, new_state}
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, @tick_period * 60 * 1000)
  end
end
