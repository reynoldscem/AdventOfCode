#!/usr/bin/ruby

def parse(line)
  line.split('x').map(&:to_i)
end

def areaForItem(line)
  sides = line.combination(2).map{|pair| pair.reduce(:*) }
  sides.map{|e|e*2}.reduce(:+) + sides.min
end

def ribbonForItem(line)
  ribbon = line.reduce(:*)
  ribbon += line.sort[0,2].map{|e| e*2 }.reduce(:+)
end

begin
  input = File.open(ARGV[0]).read.split
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  entries = input.map{|line| parse line }
  puts entries.map{|entry| areaForItem entry }.reduce(:+)
  puts entries.map{|entry| ribbonForItem entry }.reduce(:+)
end
