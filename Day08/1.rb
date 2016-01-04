#!/usr/bin/ruby

replacements =
  [[/\\"/, '.'],
   [/\\\\/, '.'],
   [/\\x[0-9a-f]{2}/, '.']
  ]

input = File.open(ARGV[0]).read.split("\n")
orig = input.map(&:length).reduce(:+)
res =
  input.map do |str|
    str = str[1...-1]
    replacements.each do |pair|
      str.gsub!(pair[0], pair[1])
    end
    str.length
  end.reduce(:+)
puts orig - res
