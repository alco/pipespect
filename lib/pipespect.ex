defmodule Pipespect do
  defmacro __using__(_) do
    quote do
      import Kernel, except: [{:|>, 2}]
      import unquote(__MODULE__), only: [{:|>, 2}]
    end
  end

  import Kernel, except: [{:|>, 2}]
  defmacro first |> rest do
    inspect = quote do: IO.inspect
    stages =
      Enum.intersperse(Enum.map(Macro.unpipe(rest), fn {x, _} -> x end), inspect)
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
