#!/usr/bin/ruby
require 'pry'

begin
  str = File.open(ARGV[0]).read.chomp
rescue
  puts "Oops"
else
  loop do
    openToClose = Hash.new
    closeToOpen = Hash.new
    (0..str.length).each do |openPos|
      if str[openPos] == '{'
        count = 1
        closePos = openPos
        until count.zero?
          closePos += 1
          count += 1 if str[closePos] == '{'
          count -= 1 if str[closePos] == '}'
        end
        openToClose[openPos] = closePos
        closeToOpen[closePos] = openPos
      end
    end
    firstRed = str.index /:\"red\"/
    break if firstRed.nil?
    str[0, firstRed].scan '{'
    openingPos = Regexp.last_match.begin(0)
    closingPos = openToClose[openingPos]
    str.slice!(openingPos, closingPos - openingPos + 1)
  end
  puts str.scan(/-*\d+/).map(&:to_i).reduce(:+)
end
