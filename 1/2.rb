#!/usr/bin/ruby

floor = 0
upsNDowns = File.open(ARGV[0]).read.chomp.split('').map{|c|c=='('?1:-1}
upsNDowns.each_with_index do |upOrDown, index|
  floor += upOrDown
  if floor == -1
    puts index + 1
    break
  end
end
