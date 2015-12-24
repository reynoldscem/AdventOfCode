#!/usr/bin/ruby

puts File.open(ARGV[0]).read.chomp.split('').map{|c|c=='('?1:-1}.reduce(:+)
