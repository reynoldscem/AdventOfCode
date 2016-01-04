#!/usr/bin/ruby
require 'pry'

class String
  def nice?
    !self.include?("ab") && !self.include?("cd") &&
    !self.include?("pq") && !self.include?("xy") &&
    !(self.scan(/[aeiou]/).length < 3) &&
    !(self.squeeze.length == self.length)
  end
end

begin
  # Make a list
  list = File.open(ARGV[0]).read.split
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  # Check it twice
  naughtyOrNice = list.select(&:nice?).select(&:nice?).length

  # Gonna find out who's naughty or nice
  puts naughtyOrNice
end
