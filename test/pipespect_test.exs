defmodule PipespectTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "plumbing works" do
    use Pipespect
    import Enum

    assert capture_io(fn ->
      [1,2,3]
      |> map(&(&1 + 1))
      |> reverse
      |> join(" . ")
    end) == ~s'[2, 3, 4]\n[4, 3, 2]\n"4 . 3 . 2"\n'
  end
end
