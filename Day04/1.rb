#!/usr/bin/ruby
require 'digest'

input = File.open(ARGV[0]).read.chomp

(1..Float::INFINITY).each do |num|
  hash = Digest::MD5.hexdigest((input + num.to_s))
  if hash[0...5] == '00000'
    puts num
    break
  end
end
