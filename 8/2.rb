#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.split("\n")
rescue
  puts "Oops"
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
