defmodule Pipespect do
  defmacro __using__(_) do
    quote do
      import Kernel, except: [{:|>, 2}]
      import unquote(__MODULE__), only: [{:|>, 2}]
    end
  end

  defmacro first |> rest do
    inspect = quote do: IO.inspect
    stages =
      rest
      |> Macro.unpipe
      |> Enum.map(fn {x, _} -> x end)
      |> Enum.intersperse(inspect)
    quote do
      unquote(first) |> unquote(rebuild_pipe(stages ++ [inspect]))
    end
  end

  defp rebuild_pipe([h]) do
    h
  end

  defp rebuild_pipe([h|t]) do
    {:|>, [], [h, rebuild_pipe(t)]}
  end
end
