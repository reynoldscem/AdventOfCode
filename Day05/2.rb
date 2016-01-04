#!/usr/bin/ruby

# Monkeypatch, find out who's naughty of nice
class String
  def nice?
    # 1st regex: Match 1 char to a group,
    # a single arbitrary char,then the same group
    # 2nd regex: Match 2 chars to a group,
    # any number of arbitrary chars, then same group
    /(.).\1/.match(self) && /(.{2}).*\1/.match(self)
  end
end

begin
  input = File.open(ARGV[0]).read.split
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  puts input.count(&:nice?)
end
