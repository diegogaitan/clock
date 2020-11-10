# Clock

**Implementation of a Clock using GenServer**

## Installation

The file `.tool-versions` for [asdf](https://github.com/asdf-vm/asdf) contains the Elixir version to use: `1.11.1`.

## Playing with the application

Through the `Clock` module to call the API methods that encapsulate the
OTP/GenServer calls:

```elixir
iex(2)> {:ok, clock} = Clock.start_link(tick_seconds: 1)
{:ok, #PID<0.243.0>}
iex(3)> Clock.time(clock)
"3:44:32 PM"
iex(4)> Clock.time(clock)
"3:44:33 PM"
iex(5)> Clock.time(clock)
"3:44:34 PM"
iex(6)> Clock.tick(clock)
:tick
iex(7)> Clock.time(clock)
"3:44:37 PM"
```

## Running tests

Run `mix test` :

```
➜  clock (master) ✗ mix test
.........

Finished in 1.1 seconds
9 tests, 0 failures

Randomized with seed 924476
```
