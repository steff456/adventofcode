defmodule Day2 do
  def is_valid_pwd(pwd, letter, min, max) do
    password =
      pwd
      |> String.to_char_list()
      |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, Map.get(acc, x, 0) + 1) end)
    [letter] = String.to_charlist(letter)
    current_value = Map.get(password, letter, 0)
    case current_value >= min and current_value <= max do
      true -> 1
      _ -> 0
    end
  end

  def is_position_valid(pwd, letter, min, max) do
    pos1 = String.at(pwd, min)
    pos2 = String.at(pwd, max)
    case pos1 == letter do
      true -> case pos2 == letter do
                true -> 0
                false -> 1
              end
      false -> case pos2 == letter do
            true -> 1
            false -> 0
      end
    end
  end

  def read_input do
    :aof2020
      |> :code.priv_dir()
      |> Path.join("day2")
      |> File.read!()
      |> String.split("\n")
  end

  def main do
    pattern = ["-", " ", ":"]
    # First star
    star_1 =
      read_input()
      |> Enum.map(fn x ->
        [min, max, letter, pwd] = String.split(x, pattern, trim: true)
        {min, _} = Integer.parse(min)
        {max, _} = Integer.parse(max)
        is_valid_pwd(pwd, letter, min, max)
        end)
      |> Enum.sum()
    star_1
    # Second star
    star_2 =
      read_input()
      |> Enum.map(fn x ->
        [min, max, letter, pwd] = String.split(x, pattern, trim: true)
        {min, _} = Integer.parse(min)
        {max, _} = Integer.parse(max)
        is_position_valid(pwd, letter, min-1, max-1)
        end)
      |> Enum.sum()
      star_2
  end

end
