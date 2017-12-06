defmodule Main do
  def start() do
    get_input()
    |> String.split("\n")
    |> Enum.at(0)
    |> String.split(" ")
    |> Enum.map(fn x ->
      String.to_integer(x)
    end)
    |> balance(%{}, 0)
    |> IO.inspect()
  end
 
  def get_input() do
    case File.read "./data/6.txt" do
      {:ok, body} -> body
      {:error, reason} -> reason
    end
  end

  def balance(input, previous_hashes, steps) do
    new_hash = :crypto.hash(:md5, input) |> Base.encode16() 
    case Map.get(previous_hashes, new_hash) do
      :nil -> 
        updated_hashes = Map.put(previous_hashes, new_hash, steps)
        iterate(input, updated_hashes, steps)
      _ -> 
        IO.puts "steps, part one answer: #{steps}"
        repeat_index = Map.get(previous_hashes, new_hash)
        IO.puts "part 2 answer: #{steps - repeat_index}"
    end
  end

  def iterate(input, previous_hashes, steps) do
    # get max
    max = Enum.max(input)
    index = Enum.find_index(input, fn x -> x == max end)
    input = List.replace_at(input, index, 0)

    {_, return_array} = Enum.reduce((index)..(index + max - 1), {index, input}, fn(_, {counter, return_array}) ->
      counter = counter + 1
      case counter > length(input)-1 do
        :true ->
          new_array = List.update_at(return_array, 0, &(&1 + 1))
          {0, new_array}
        :false ->
          new_array = List.update_at(return_array, counter, &(&1 + 1))
          {counter, new_array}
      end
    end)
    balance(return_array, previous_hashes, steps + 1)
  end
end

Main.start()
