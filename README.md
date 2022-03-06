# PIRMotionSensor
Support for [AdaFruit PIR motion sensor](https://www.adafruit.com/product/189)

Primary interface is `PIRMotionSensor.motion_detected(pin)` atm, but PRs
expanding on a polling-and-messaging interface are welcome

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `pir_motion_sensor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pir_motion_sensor, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/pir_motion_sensor](https://hexdocs.pm/pir_motion_sensor).

