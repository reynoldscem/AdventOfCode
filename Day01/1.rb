#!/usr/bin/ruby

begin
  puts File.open(ARGV[0]).read.chomp.split('').map do |c|
    c == '(' ? 1 : -1
  end.reduce(:+)
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
end
