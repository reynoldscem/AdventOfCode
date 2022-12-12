#!/usr/bin/ruby

begin
  str = File.open(ARGV[0]).read.chomp
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  puts str.scan(/-*\d+/).map(&:to_i).reduce(:+)
end
