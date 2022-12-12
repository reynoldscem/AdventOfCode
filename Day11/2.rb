#!/usr/bin/ruby

# Monkeypatch to see if a string is ascending
class String
  def incrementing?
    (1..length - 1).each do |i|
      return false if (self[i].ord - self[i - 1].ord) != 1
    end
    true
  end

  def valid?
    substrings = []
    (0..(length - 3)).each do |i|
      substrings << self[i, 3]
    end
    substrings.any?(&:incrementing?) &&
      !match(/i|o|u/) &&
      scan(/((.)\2{1,})/).map(&:first).length >= 2
  end
end

begin
  str = File.open(ARGV[0]).read.chomp
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  str.next! until str.valid?
  str.next!
  str.next! until str.valid?
  puts str
end
