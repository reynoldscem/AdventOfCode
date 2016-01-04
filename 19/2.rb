#!/usr/bin/ruby

begin
  input = File.readlines(ARGV[0])
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  molecule = input[-1].chomp
  totalEls = molecule.scan(/[A-Z][a-z]?/).length
  brackets = molecule.scan(/Ar|Rn/).length
  separate = molecule.scan(/Y/).length
  puts totalEls - brackets - 2*separate - 1
end
