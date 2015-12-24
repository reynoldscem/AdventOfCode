#!/usr/bin/ruby

begin
  upsNDowns = File.open(ARGV[0]).read.chomp.split('').map{|c|c=='('?1:-1}
rescue
  puts "Oops"
else
  floor = 0
  upsNDowns.each_with_index do |upOrDown, index|
    floor += upOrDown
    if floor == -1
      puts index + 1
      break
    end
  end
end
