defmodule Main do
  def start() do
    get_input()
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> move(0, 0)
    |> IO.inspect()
  end

  def get_input() do
    case File.read "./data/5.txt" do
      {:ok, body} -> body
      {:error, reason} -> reason
    end
  end

  # when index is out of bounds, do this
  def move(input, index, count) when index >= length(input) do
    IO.puts count
  end

  def move(input, index, count) do
    # get input at index
    cur_val = Enum.at(input, index)
    # ONLY FOR CHALLENGE 2
    modifier = case cur_val >= 3 do
      :true -> -1
      :false -> 1
    end
    # next index we look at is the current value we're looking at plus the current index
    next_index = index + cur_val
    # update the val to val + 1 and set back in the current index
    List.update_at(input, index, &(&1 + modifier))
    |> move(next_index, count + 1)
  end
end

Main.start()
