#!/usr/bin/ruby

begin
  result = File.open(ARGV[0]).read.chomp.split('').map do |c|
    c == '(' ? 1 : -1
  end.reduce(:+)
  puts result
rescue => error
  p error
  puts 'Valid input file from AdventOfCode required as first argument.'
end
