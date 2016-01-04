#!/usr/bin/ruby

begin
  ups_and_downs =
    File.open(ARGV[0]).read.chomp.split('').map { |c| c == '(' ? 1 : -1 }
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  floor = 0
  ups_and_downs.each_with_index do |up_or_down, index|
    floor += up_or_down
    if floor == -1
      puts index + 1
      break
    end
  end
end
