#!/usr/bin/ruby

begin
  str = File.open(ARGV[0]).read
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  50.times do
    smashed = str.scan(/((\d)\2*)/).map(&:first)
    lengths = smashed.map(&:length).map(&:to_s)
    chars = smashed.map { |e| e.split('').uniq }.flatten
    str = lengths.zip(chars).flatten.join
  end
  puts str.length
end
