defmodule Day3 do

  def read_input do
    :aof2020
      |> :code.priv_dir()
      |> Path.join("day3")
      |> File.read!()
      |> String.split("\n")
  end

  def calc_slope(count, position, right_shift, x) do
    cur_string = String.at(x, position)
    case cur_string == "#" do
      true -> count = count + 1
              position = rem(position + right_shift, 31)
              {count, position}
      false -> position = rem(position + right_shift, 31)
               {count, position}
    end
  end

  def main do
    # First star
    {star_1_count, _, _} =
      read_input()
      |> Enum.reduce({0, 3, true}, fn x, {count, position, first} ->
          case first do
            true -> {count, position, false}
            false -> cur_string = String.at(x, position)
                    case cur_string == "#" do
                      true -> count = count + 1
                              position = rem(position + 3, 31)
                              {count, position, false}
                      false -> position = rem(position + 3, 31)
                              {count, position, false}
                    end
        end
       end)

    # Second star
    {slope_1_count, _, _} =
      read_input()
      |> Enum.reduce({0, 2, true}, fn x, {count, position, first} ->
        case first do
          true -> {count, position, false}
          false -> {count, position} = calc_slope(count, position, 1, x)
                   {count, position, false}
        end
      end)

    {slope_5_count, _, _} =
      read_input()
      |> Enum.reduce({0, 5, true}, fn x, {count, position, first} ->
        case first do
          true -> {count, position, false}
          false -> {count, position} = calc_slope(count, position, 5, x)
                    {count, position, false}
        end
      end)

    {slope_7_count, _, _} =
      read_input()
      |> Enum.reduce({0, 7, true}, fn x, {count, position, first} ->
        case first do
          true -> {count, position, false}
          false -> {count, position} = calc_slope(count, position, 7, x)
                    {count, position, false}
        end
      end)

    {slope_2d_count, _, _, _} =
        read_input()
        |> Enum.reduce({0, 1, true, false}, fn x, {count, position, first, down} ->
          case first do
            true -> {count, position, false, false}
            false -> case down do
                    true -> {count, position} = calc_slope(count, position, 1, x)
                            {count, position, false, false}
                    false -> {count, position, false, true}
            end
          end
        end)

    :logger.debug("#{inspect star_1_count} - #{inspect slope_1_count} - #{inspect slope_5_count} - #{inspect slope_7_count} - #{inspect slope_2d_count}")
    star_1_count * slope_1_count * slope_5_count * slope_7_count * slope_2d_count
  end

end
