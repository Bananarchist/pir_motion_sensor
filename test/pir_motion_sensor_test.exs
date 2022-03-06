defmodule PIRMotionSensorTest do
  use ExUnit.Case
  doctest PIRMotionSensor

  test "returns true if sensor detects motion" do
    {:ok, gpio0} = Circuits.GPIO.open(0, :output)
    Circuits.GPIO.write(gpio0, 1)
    assert PIRMotionSensor.motion_detected(1) == true
  end
  test "returns false if sensor detects no motion" do
    {:ok, gpio0} = Circuits.GPIO.open(0, :output)
    Circuits.GPIO.write(gpio0, 0)
    assert PIRMotionSensor.motion_detected(1) == false
  end
end

