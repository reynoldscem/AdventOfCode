#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  row_ind = col_ind = 0
  grid = {}
  input.split('').each do |char|
    grid[[row_ind, col_ind]] ||= 0
    grid[[row_ind, col_ind]] += 1

    case char
    when '^'
      row_ind += 1
    when 'v'
      row_ind -= 1
    when '>'
      col_ind += 1
    when '<'
      col_ind -= 1
    end
  end

  puts grid.values.length
end
