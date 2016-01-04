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

# Make a list
list = File.open(ARGV[0]).read.split

# Check it twice
naughtyOrNice = list.select(&:nice?).select(&:nice?).length

# Gonna find out who's naughty or nice
puts naughtyOrNice
