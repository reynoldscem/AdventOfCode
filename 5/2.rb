#!/usr/bin/ruby
require 'pry'

class String
  def nice?
    # 1st regex: Match 1 char to a group, a single arbitrary char,then the same group
    # 2nd regex: Match 2 chars to a group, any number of arbitrary chars, then same group
    /(.).\1/.match(self) && /(.{2}).*\1/.match(self)
  end
end

input = File.open(ARGV[0]).read.split
puts input.select(&:nice?).length
