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

input = File.open(ARGV[0]).read.split
puts input.select(&:nice?).length
