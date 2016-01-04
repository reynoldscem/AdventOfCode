#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.split("\n").map(&:to_i)
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  combs = (1..(input.length)).flat_map { |n| input.combination(n).to_a }
  comb_lengths = combs.map { |arr| arr.reduce(:+) }
  num_elems = combs.map(&:length)
  zipped = num_elems.zip(comb_lengths)
  successful = zipped.select { |entry| entry[1] == 150 }
  min_num = successful.first[0]
  puts successful.count { |entry| entry[0] == min_num }
end
