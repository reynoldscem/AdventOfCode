#!/usr/bin/ruby
require 'pry'

@lim = 100

def dispLights(lights)
  system("clear")
  lights.each do |row|
    row = row.map(&:to_s).join.gsub(/0/,' ').gsub(/1/,'#')
    puts row, row.reverse
    puts
  end
end

def inBounds(row, col)
  row >=0 && row < @lim && col >= 0 && col < @lim
end

def nextState(lights, row, col)
  modifier = ->(val) {[-1, 0, 1].map {|e| e + val }}
  rowMod = modifier.call(row)
  colMod = modifier.call(col)
  neighbours = rowMod.product(colMod) - [[row, col]]
  neighbourStates =
    neighbours.map{|pair| inBounds(*pair) ? lights[pair[0]][pair[1]] : 0 }
  sum = neighbourStates.reduce(:+)
  sum == 3 || (lights[row][col] == 1 ? sum == 2 : false)
end

begin
  input = File.read(ARGV[0])
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  lights = input.gsub(/#/,'1')
                .gsub(/\./,'0')
                .split
                .map do |line|
                  line.split('').map(&:to_i)
                 end
  dispLights(lights)
  100.times do
    lastEpoch = Marshal.load(Marshal.dump(lights))
    (0...@lim).each do |row|
      (0...@lim).each do |col|
        lights[row][col] = nextState(lastEpoch, row, col) ? 1 : 0
      end
    end
    lights[0][0] = 1
    lights[99][99] = 1
    lights[0][99] = 1
    lights[99][0] = 1
    dispLights(lights)
  end
  puts lights.flatten.reduce(:+)
end
