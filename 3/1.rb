#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  rowInd = colInd = 0
  grid = Hash.new
  input.split('').each do |char|
    grid[[rowInd, colInd]] ||= 0
    grid[[rowInd, colInd]] += 1

    case char
    when '^'
      rowInd += 1
    when 'v'
      rowInd -= 1
    when '>'
      colInd += 1
    when '<'
      colInd -= 1
    end
  end

  puts grid.values.length
end
