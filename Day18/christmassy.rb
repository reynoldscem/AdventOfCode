#!/usr/bin/ruby
require 'pry'

@rows = 100
@cols = 180

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

def dispLights(lights)
  system("clear")
  lights.each do |row|
    thisRow = row.map(&:to_s).join.gsub(/0/,' ').gsub(/1/,'#')
    thisRow.split('').each do |pixel|
      colour = rand > 0.5 ? :red : :green
      print pixel.send(colour)
    end
    puts
  end
  sleep 0.1
end

def inBounds(row, col)
  row >=0 && row < @rows && col >= 0 && col < @cols
end

def nextState(lights, row, col)
  rowMod = [-1, 0, 1].map {|e| e + row }
  colMod = [-1, 0, 1].map {|e| e + col }
  neighbours = rowMod.product(colMod) - [[row, col]]
  neighbourStates =
    neighbours.map{|pair| inBounds(*pair) ? lights[pair[0]][pair[1]] : 0 }
  sum = neighbourStates.reduce(:+)
  if lights[row][col] == 1
    sum == 2 || sum == 3
  else
    sum == 3
  end
end

lights = Array.new(100) {Array.new(100){0}}
(0...@rows).each do |row|
  (0...@cols).each do |col|
  lights[row][col] = rand > 0.90 ? 1 : 0
  end
end

dispLights(lights)
loop do
  lastEpoch = Marshal.load(Marshal.dump(lights))
  (0...@rows).each do |row|
    (0...@cols).each do |col|
      lights[row][col] = nextState(lastEpoch, row, col) ? 1 : 0
    end
  end
  # sleep(2)
  dispLights(lights)
end
