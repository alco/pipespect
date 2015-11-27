defmodule Pipespect do
  defmacro __using__(_) do
    quote do
      import Kernel, except: [{:|>, 2}]
      import unquote(__MODULE__), only: [{:|>, 2}]
    end
  end

  import Kernel, except: [{:|>, 2}]
  defmacro first |> rest do
    inspect_fragment = quote do: IO.inspect
    input_pipeline = Enum.map(Macro.unpipe(first) ++ Macro.unpipe(rest), fn {x, _} -> x end)
    output_pipeline = Enum.intersperse(input_pipeline, inspect_fragment)
    # We call List.delete_at below so that we don't inspect the first argument in the pipeline
    rebuild_pipe(List.delete_at(output_pipeline, 1) ++ [inspect_fragment])
  end

  @pipe_op {:., [], [Kernel, :|>]}

  defp rebuild_pipe([result]) do
    result
  end

  defp rebuild_pipe([left, right | rest]) do
    rebuild_pipe([{@pipe_op, [], [left, right]} | rest])
  end
end
