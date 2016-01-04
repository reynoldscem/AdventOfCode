#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.split("\n").map(&:to_i)
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  combs = (1..(input.length)).flat_map{|n| input.combination(n).to_a}
  combLengths = combs.map{|arr| arr.reduce(:+)}
  numElems = combs.map{|entry| entry.length}
  zipped = numElems.zip(combLengths)
  successful = zipped.select{|entry| entry[1] == 150}
  minNum = successful.first[0]
  puts successful.select{|entry| entry[0] == minNum}.length
end
