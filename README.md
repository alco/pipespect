Pipespect
=========

Inspect each stage of a pipeline.

```elixir
import Enum

[1,2,3] |> reverse |> map(& &1*&1) |> join(" . ")
# output: none

use Pipespect
[1,2,3] |> reverse |> map(& &1*&1) |> join(" . ")
# output:
#   [3, 2, 1]
#   [9, 4, 1]
#   "9 . 4 . 1"
```

## License

This software is licensed under [the MIT license](LICENSE).
