#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  rows = input.split[-3].to_i
  cols = input.split[-1].to_i
  n = rows + cols
  iter = (n - 2) * (n - 1) / 2 + cols - 1
  val = 20_151_125
  multiplier = 252_533
  modulo_by = 33_554_393
  iter.times do
    val = (val * multiplier) % modulo_by
  end
  puts val
end
