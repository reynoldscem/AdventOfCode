#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.split("\n")
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  orig = input.map {|x| x.length}
  res = input.map do |str|
    str.gsub(/\\/,"..")
       .gsub(/\"/,"..")
       .gsub(/\\x[0-9a-f]{2}/,".....")
       .length + 2
    end
  puts res.reduce(:+) - orig.reduce(:+)
end
