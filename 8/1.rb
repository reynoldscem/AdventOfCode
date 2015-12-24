#!/usr/bin/ruby
require 'pry'

input = File.open(ARGV[0]).read.split("\n")
orig = input.map{|x| x.length}.reduce(:+)
res = input.map do |str|
  str[1...-1].gsub(/\\"/,".")
             .gsub(/\\\\/,".")
             .gsub(/\\x[0-9a-f]{2}/,".").length
  end.reduce(:+)
puts orig - res
