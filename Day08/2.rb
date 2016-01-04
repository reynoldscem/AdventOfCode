#!/usr/bin/ruby

replacements =
  [[/\\/, '..'],
   [/\"/, '..'],
   [/\\x[0-9a-f]{2}/, '.....']
  ]

begin
  input = File.open(ARGV[0]).read.split("\n")
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  orig = input.map(&:length)
  res =
    input.map do |str|
      replacements.each do |replacement|
        str.gsub!(replacement[0], replacement[1])
      end
      str.length + 2
    end
  puts res.reduce(:+) - orig.reduce(:+)
end
