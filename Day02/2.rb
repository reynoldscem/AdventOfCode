#!/usr/bin/ruby

def parse(line)
  line.split('x').map(&:to_i)
end

def ribbon_for_item(line)
  line.reduce(:*) + line.sort[0, 2].map { |e| e * 2 }.reduce(:+)
end

begin
  input = File.open(ARGV[0]).read.split
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  entries = input.map { |line| parse line }
  puts entries.map { |entry| ribbon_for_item entry }.reduce(:+)
end
