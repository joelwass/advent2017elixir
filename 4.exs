defmodule Main do
  def start_1() do
    get_input()
    |> String.split("\n")
    |> split_by_space()
    |> valid_passphrases()
    |> IO.inspect()
  end

  def start_2() do
    get_input()
    |> String.split("\n")
    |> split_by_space_and_sort()
    |> valid_passphrases()
    |> IO.inspect()
  end

  def get_input() do
    case File.read "./data/4.txt" do
      {:ok, body} -> body
      {:error, reason} -> reason
    end
  end

  def split_by_space(input) do
    Enum.map(input, fn(x) -> 
      String.split(x, " ")
    end)
  end

  def split_by_space_and_sort(input) do
    Enum.map(input, fn(x) ->
      String.split(x, " ")
      |> Enum.map(fn x -> x |> String.to_charlist() |> Enum.sort() end)
    end)
  end

  def valid_passphrases(input) do
    Enum.reduce(input, 0, fn(x, acc) ->
      full_length = length(x)
      new_length = Enum.uniq(x)
                   |> length()
      case full_length == new_length do
        :true -> acc + 1
        :false -> acc
      end
    end)
  end

  
end

Main.start_2()
