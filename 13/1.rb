#!/usr/bin/ruby
require 'pry'

def validPath?(adjMat, path, namesToIndices)
  (1...(path.length)).each do |index|
    return false if adjMat[namesToIndices[path[index-1]]][namesToIndices[path[index]]].zero?
  end
  true
end

def pathLength(adjMat, path, namesToIndices)
  length = 0;
  (1...(path.length)).each do |index|
    length += adjMat[namesToIndices[path[index-1]]][namesToIndices[path[index]]]
  end
  length
end

begin
  input = File.open(ARGV[0]).read
rescue
  puts "Oops"
else
  replacementHash = { /lose / => "-",/gain/=>"", / would/=>"",
                      / happiness units by sitting next to/=>"", /\./=>""}
  replacementHash.each{|h,k| input.gsub!(h,k)}
  input = input.split("\n")
  names = input.map {|item| a = item.split; [a[0], a[2]]}.flatten.uniq.sort
  namesToIndices = Hash[names.map.with_index.to_a]
  adjMat = Array.new(names.length) { Array.new(names.length) {0} }
  tuples = input.map {|line| line.split }
  tuples.each do |tuple|
    adjMat[namesToIndices[tuple[0]]][namesToIndices[tuple[2]]] += tuple[1].to_i
    adjMat[namesToIndices[tuple[2]]][namesToIndices[tuple[0]]] += tuple[1].to_i
  end
  # O(|names|!), but who cares?
  possiblePaths = names.permutation.to_a.select do |path|
    path << path[0]
    #validPath?(adjMat, path, namesToIndices)
  end
  binding.pry
  best = Hash[possiblePaths.map do |path|
    pathLength(adjMat, path, namesToIndices)
  end.zip(possiblePaths)].max
  puts "Best path is:"
  best[1].each {|city| print(city, " ") }
  puts
  print("Length ", best[0])
  puts
end
