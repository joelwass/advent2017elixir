#!/usr/bin/env elixir

defmodule Main do
  def start() do
    get_input()
    |> String.split("\n")
    |> iterate_2()
    |> IO.inspect()
  end

  def get_input() do
    case File.read "./data/2.txt" do
      { :ok, body } -> body
      { :error, reason } -> reason
    end
  end

  def iterate_1(input) do
    Enum.reduce(input, {0}, fn (numbers, {checksum}) -> 
      new_array = String.split(numbers, " ")
                  |> Enum.map(fn(x) -> 
                    String.to_integer(x)
                  end)
      max = Enum.max(new_array)
      min = Enum.min(new_array)
      difference = max - min
      {checksum + difference}
    end)
  end

  def iterate_2(input) do
    Enum.reduce(input, {0}, fn (numbers, {checksum}) ->
      int_input = String.split(numbers, " ")
      |> Enum.map(fn(x) ->
        String.to_integer(x)
      end)
      |> Enum.sort()
      |> Enum.reverse()
     
      wtf = Enum.with_index(int_input)
      |> Enum.reduce(0, fn (tup, acc1) -> 
        value = elem(tup, 0)
        index = elem(tup, 1)
        rest = index + 1 - length(int_input)

        remaining_values = Enum.take(int_input, rest)
        retValue = Enum.reduce(remaining_values, 0, fn(n, acc) ->
          case rem(value, n) == 0 do
            :true -> acc + round(value / n) 
            :false -> acc 
          end
        end) 
        acc1 + retValue
      end)
      { checksum + wtf } 
    end)
  end
end

Main.start()
