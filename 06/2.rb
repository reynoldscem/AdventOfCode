#!/usr/bin/ruby
require 'pry'

input = File.open(ARGV[0]).read.split("\n").map do |instruction|
  instruction.gsub("through ", "").gsub("turn ", "").gsub(","," ")
end

@lightGrid = Array.new(1000) { Array.new(1000) {0} }

def getIndices(startRow, startCol, finRow, finCol)
  (startRow..finRow).to_a.product((startCol..finCol).to_a)
end

def toggle(indices)
  getIndices(*indices).each do |light|
    @lightGrid[light[0]][light[1]] += 2
  end
end

def off(indices)
  getIndices(*indices).each do |light|
    @lightGrid[light[0]][light[1]] -= 1 unless @lightGrid[light[0]][light[1]].zero?
  end
end

def on(indices)
  getIndices(*indices).each do |light|
    @lightGrid[light[0]][light[1]] += 1
  end
end

input.each_with_index do |instruction, index|
  tokens = instruction.split
  send(tokens.first, tokens[1..4].map(&:to_i))
end
puts @lightGrid.flatten.select{|x|x}.reduce(:+)
