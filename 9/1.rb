#!/usr/bin/ruby
require 'pry'

def validPath?(adjMat, path, citiesToIndices)
  (1...(path.length)).each do |index|
    return false if adjMat[citiesToIndices[path[index-1]]][citiesToIndices[path[index]]].zero?
  end
  true
end

def pathLength(adjMat, path, citiesToIndices)
  length = 0;
  (1...(path.length)).each do |index|
    length += adjMat[citiesToIndices[path[index-1]]][citiesToIndices[path[index]]]
  end
  length
end

begin
  input = File.open(ARGV[0]).read.split("\n")
rescue
  puts "Oops"
else
  cities = input.join.gsub(/ to /," ").gsub(/\d/,"").gsub(/=/,"").split.uniq.sort
  citiesToIndices = Hash[cities.map.with_index.to_a]
  adjMat = Array.new(cities.length) { Array.new(cities.length) {0} }
  tuples = input.map {|line| line.gsub(/ to /, " ").gsub(/= /,"").split }
  tuples.each do |tuple|
    adjMat[citiesToIndices[tuple[0]]][citiesToIndices[tuple[1]]] = tuple[2].to_i
    adjMat[citiesToIndices[tuple[1]]][citiesToIndices[tuple[0]]] = tuple[2].to_i
  end
  # O(|cities|!), but who cares?
  possiblePaths = cities.permutation.to_a.select do |path|
    validPath?(adjMat, path, citiesToIndices)
  end
  best = Hash[possiblePaths.map do |path|
    pathLength(adjMat, path, citiesToIndices)
  end.zip(possiblePaths)].max
  puts "Best path is:"
  best[1].each {|city| print(city, " ") }
  puts
  print("Length ", best[0])
  puts
end
