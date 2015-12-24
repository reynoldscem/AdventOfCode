#!/usr/bin/ruby

input = File.open(ARGV[0]).read
roboTurn = false
grid = Hash.new
grid[[0,0]] = 2;
Indices = Struct.new(:rowInd, :colInd);
santa = Indices.new(0, 0);
roboSanta = Indices.new(0, 0);
input.split('').each do |char|
  rowInd, colInd =
  if roboTurn
    roboSanta
  else
    santa
  end.to_a

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

  if grid[[rowInd, colInd]].nil?
    grid[[rowInd, colInd]] = 1
  else
    grid[[rowInd, colInd]] += 1
  end

  if roboTurn
    roboSanta[:rowInd] = rowInd
    roboSanta[:colInd] = colInd
  else
    santa[:rowInd] = rowInd
    santa[:colInd] = colInd
  end
  roboTurn = !roboTurn
end
puts grid.values.length
