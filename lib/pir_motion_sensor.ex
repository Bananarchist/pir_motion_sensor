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
      poll_time: 60_000,
      gpio_pin: 1
    }
  end

  @impl true
  def init(opts) do
    {:ok,
     %{
       poll_time: opts[:poll_time],
       gpio_pin: opts[:gpio_pin],
       motion_sensed: false,
       listening: nil
     }}
  end

  defp poll(next) do
    Process.send_after(self(), :poll, next)
  end

  @impl true
  def handle_info(:poll, state) do
    poll(state[:poll_time])
    {:noreply, %{state | motion_sensed: motion_detected(state[:gpio_pin])}}
  end

  @impl true
  def handle_call(:listen, {from, _msg}, state) do
    poll(state[:poll_time])
    {:reply, %{state | listening: from, motion_sensed: motion_detected(state[:gpio_pin])}}
  end
end
