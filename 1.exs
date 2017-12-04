#!/usr/bin/env elixir

defmodule Main do
  def start() do
    getInput()
    |> String.codepoints
    |> iterate_part2()
    |> IO.inspect()
  end

  def getInput() do
    case File.read "./data/1.txt" do
      { :ok, body } -> body
      { :error, reason } -> reason
    end
  end

  def iterate_part1(input) do
    Enum.drop(input, -1)
    |> Enum.map(fn(x) ->
      # convert each to an integer
      String.to_integer(x)
    end)
    |> (fn input -> Enum.reduce(input, {List.last(input), 0}, fn(item, {prev, acc}) ->
      # look at previous value and see if it's the same as current value
      case item == prev do
        :true -> {item, acc + item}
        :false -> {item, acc} 
      end
    end)end).()
    |> (fn input -> elem(input, 1) end).()
  end

  def iterate_part2(input) do
    # concat the list together to double the size
    input2 = Enum.drop(input, -1)
             |> Enum.map(fn(x) ->
               String.to_integer(x)
             end)

    # concat the good input together to create "circular" array
    double_input = input2 ++ input2

    # iterate over with index and just look at index + len(list) and see if it's the same
    Enum.with_index(input2)
    |> (fn input -> Enum.reduce(input, {0}, fn (x, {acc}) -> 
      index_to_check = round(elem(x, 1) + (length(input) / 2))
      lookup_value = Enum.at(double_input, index_to_check)
      case lookup_value == elem(x, 0) do
        :true -> {acc + lookup_value} 
        :false -> {acc} 
      end
    end)end).()
    |> (fn input -> elem(input, 0) end).()
  end
end

Main.start()
