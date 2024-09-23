defmodule Identicone.Image do
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil

  @type t :: %__MODULE__{hex: list(number()), color: tuple(), pixel_map: list(tuple())}

end
