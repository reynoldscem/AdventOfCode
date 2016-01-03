#!/usr/bin/ruby
require 'pry'

def setDiff(s1, s2)
  s1 - s2 | s2 - s1
end

def elementsToReachSum(array, limit)
  (1..array.length).each do |n|
    return n if array.take(n).reduce(:+) >= limit
  end
end

def choiceForNBins(presents, n)
  return presents if n == 1
  presentsTotalWeight = presents.reduce(:+)
  desiredWeight = presentsTotalWeight / n

  max = elementsToReachSum(presents, desiredWeight)
  min = elementsToReachSum(presents.reverse, desiredWeight)

  (min..max).lazy.map do |count|
    presents.combination(count).find do |combination|
      combination.reduce(:+) == desiredWeight &&
      choiceForNBins(presents - combination, n - 1)
    end
  end.find{|x| !x.empty?}
end

begin
  presents = File.readlines(ARGV[0]).map(&:to_i)
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  puts choiceForNBins(presents, 4).reduce(:*)
end
