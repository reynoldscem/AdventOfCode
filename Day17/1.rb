#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.split("\n").map(&:to_i)
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  combs = (1..(input.length)).flat_map { |n| input.combination(n).to_a }
  comb_lengths = combs.map { |arr| arr.reduce(:+) }
  puts comb_lengths.count { |capacity| capacity == 150 }
end
