#!/usr/bin/ruby

begin
  puts File.open(ARGV[0]).read.chomp.split('').map{|c|c=='('?1:-1}.reduce(:+)
rescue
  puts "Valid input file from AdventOfCode required as first argument."
end
