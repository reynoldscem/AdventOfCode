#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts "Oops"
else
  rowInd = 0
  colInd = 0
  grid = Hash.new
  input.split('').each do |char|
    if grid[[rowInd, colInd]].nil?
      grid[[rowInd, colInd]] = 1
    else
      grid[[rowInd, colInd]] += 1
    end
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
