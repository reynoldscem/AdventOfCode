#!/usr/bin/ruby

begin
  str = File.open(ARGV[0]).read.chomp
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  loop do
    open_to_close = {}
    close_to_open = {}
    (0..str.length).each do |open_pos|
      next unless str[open_pos] == '{'
      count = 1
      close_pos = open_pos
      until count.zero?
        close_pos += 1
        count += 1 if str[close_pos] == '{'
        count -= 1 if str[close_pos] == '}'
      end
      open_to_close[open_pos] = close_pos
      close_to_open[close_pos] = open_pos
    end
    first_red = str.index(/:\"red\"/)
    break if first_red.nil?
    str[0, first_red].scan '{'
    opening_pos = Regexp.last_match.begin(0)
    closing_pos = open_to_close[opening_pos]
    str.slice!(opening_pos, closing_pos - opening_pos + 1)
  end
  puts str.scan(/-*\d+/).map(&:to_i).reduce(:+)
end
