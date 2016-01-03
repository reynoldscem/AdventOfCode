#!/usr/bin/ruby
require 'pry'

def parse(line)
  line.split('x').map(&:to_i)
end

def areaForItem(line)
  l = line[0]
  w = line[1]
  h = line[2]
  sides = []
  sides[0] = l*w
  sides[1] = w*h
  sides[2] = h*l
  sides.map{|e|e*2}.reduce(:+) + sides.min
end

def ribbonForItem(line)
  l = line[0]
  w = line[1]
  h = line[2]
  ribbon = l*w*h
  sides = line.sort
  ribbon += 2*sides[0]
  ribbon += 2*sides[1]
end

begin
  input = File.open(ARGV[0]).read.split
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  totalArea = 0
  totalRibbon = 0
  input.each do |line|
    entry = parse line
    totalArea += areaForItem entry
    totalRibbon += ribbonForItem entry
  end

  puts totalArea
  puts totalRibbon
end
