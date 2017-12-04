#!/usr/bin/env elixir

defmodule Main do
  def start() do
    iterate(368078)
    |> IO.inspect()
  end

  def iterate(val) do
    Enum.reduce(2..val, {0, 0, 0, -1}, fn (i, {x, y, dx, dy}) ->
      if ((-val/2 < x and x <= val/2) and (-val/2 < y and y <= val/2)) do
        IO.inspect "#{x} #{y}"
      end
      if ((x == y) or (x < 0 and x == -y) or (x > 0 and x == 1-y)) do
        tmp = dx
        dx = -dy
        dy = tmp
      end
      {x + dx, y + dy, dx, dy}
    end)
  end
end

Main.start()
