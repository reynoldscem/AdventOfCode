#!/usr/bin/ruby

File.open(ARGV[0]).read.split("\n").tap{|a|p a.map{|x|x.length}.reduce(:+)-a.map{|b|b[1...-1].gsub(/\\"/,".").gsub(/\\\\/,".").gsub(/\\x[0-9a-f]{2}/,".").length}.reduce(:+)}
