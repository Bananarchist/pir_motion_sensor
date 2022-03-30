defmodule PIRMotionSensor do
  alias Circuits.GPIO
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def motion_detected(pin) when is_number(pin) do
    {:ok, gpio} = GPIO.open(pin, :input)
    if GPIO.read(gpio) == 1, do: true, else: false
  end

  def default_options do
    %{
      gpio_pin: 17
    }
  end

  @impl true
  def init(opts) do
    {:ok, gpio} = GPIO.open(opts[:gpio_pin], :input)

    {:ok,
     %{
       gpio_pin: opts[:gpio_pin],
       gpio_ref: gpio,
       motion: false
       # history: [],
     }}
  end

  @impl true
  def handle_cast({:circuits_gpio, _pin, _timestamp, 1}, state),
    do: {:noreply, %{state | motion: true}}

  @impl true
  def handle_cast({:circuits_gpio, _pin, _timestamp, _value}, state),
    do: {:noreply, %{state | motion: false}}

  @impl true
  def handle_call(:motion_detected, _from, state) do
    {:reply, state[:motion], state}
  end
end
