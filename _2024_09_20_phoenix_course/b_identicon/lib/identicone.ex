defmodule Identicone do
  def gen_identicone(name) do
    name
    |> generate_hash
    |> get_color
    |> build_grid
    |> filter_odd_squares
    |> generate_pixel_map
    |> draw_image
    |> save_image(name)
  end

  defp generate_hash(name) do
    hex =
      :crypto.hash(:md5, name)
      |> :binary.bin_to_list()

    %Identicone.Image{hex: hex}
  end

  defp get_color(%Identicone.Image{hex: [r, g, b | _]} = image) do
    %Identicone.Image{image | color: {r, g, b}}
  end

  defp build_grid(%Identicone.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicone.Image{image | grid: grid}
  end

  defp mirror_row([first, second | _tail] = row), do: row ++ [second, first]

  defp filter_odd_squares(%Identicone.Image{grid: grid} = image) do
    grid = Enum.filter(grid, fn {numb, _} -> rem(numb, 2) == 0 end)
    %Identicone.Image{image | grid: grid}
  end

  defp generate_pixel_map(%Identicone.Image{grid: grid} = image) do
    pixel_map =
      grid
      |> Enum.map(fn {_, index} ->
        hor = rem(index, 5) * 50
        ver = div(index, 5) * 50
        top_left = {hor, ver}
        bot_right = {hor + 50, ver + 50}
        {top_left, bot_right}
      end)

    %Identicone.Image{image | pixel_map: pixel_map}
  end

  defp draw_image(%Identicone.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    Enum.each(pixel_map, fn {start, stop} -> :egd.filledRectangle(image, start, stop, fill) end)
    :egd.render(image, :eps)
  end

  defp save_image(image, name), do: File.write("#{name}.eps", image)
end
