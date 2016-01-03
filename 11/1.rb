#!/usr/bin/ruby

class String
  def incrementing?
    (1..self.length-1).each do |i|
      return false if (self[i].ord - self[i-1].ord) != 1
    end
    true
  end

  def valid?
    subStrings = []
    (0..(self.length - 3)).each do |i|
      subStrings << self[i, 3]
    end
    subStrings.any? {|subStr| subStr.incrementing? } &&
    !self.match(/i|o|u/) &&
    self.scan(/((.)\2{1,})/).map{:first}.length >= 2
  end
end

begin
  str = File.open(ARGV[0]).read.chomp
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  str.next! until str.valid?
  puts str
end
