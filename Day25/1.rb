#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  rows = input.split[-3].to_i
  cols = input.split[-1].to_i
  n = rows + cols;
  iter = (n - 2) * (n - 1) / 2 + cols - 1
  val = 20151125
  multiplier = 252533
  moduloBy = 33554393
  iter.times do
    val = (val * multiplier) % moduloBy
  end
  puts val
end
