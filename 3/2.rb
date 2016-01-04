#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  roboTurn = false
  grid = Hash.new
  grid[[0,0]] = 2;
  Indices = Struct.new(:rowInd, :colInd);
  santa = Indices.new(0, 0);
  roboSanta = Indices.new(0, 0);
  input.split('').each do |char|
    rowInd, colInd = (roboTurn ? roboSanta : santa).to_a

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

    grid[[rowInd, colInd]] ||= 0
    grid[[rowInd, colInd]] += 1

    thisSanta = roboTurn ? roboSanta : santa
    thisSanta[:rowInd] = rowInd
    thisSanta[:colInd] = colInd
    roboTurn = !roboTurn
  end
  puts grid.values.length
end
