defmodule Pipespect.Mixfile do
  use Mix.Project

  def project do
    [app: :pipespect,
     version: "0.9.0",
     elixir: ">= 0.13.0 and != 0.14.3"]
  end
end
