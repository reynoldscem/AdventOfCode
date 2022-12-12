#!/usr/bin/ruby

def parse(line)
  line.split('x').map(&:to_i)
end

def area_for_item(line)
  sides = line.combination(2).map { |pair| pair.reduce(:*) }
  sides.map { |e| e * 2 }.reduce(:+) + sides.min
end

begin
  input = File.open(ARGV[0]).read.split
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  entries = input.map { |line| parse line }
  puts entries.map { |entry| area_for_item entry }.reduce(:+)
end
