#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  robo_turn = false
  grid = {}
  grid[[0, 0]] = 2
  Indices = Struct.new(:row_ind, :col_ind)
  santa = Indices.new(0, 0)
  robo_santa = Indices.new(0, 0)
  input.split('').each do |char|
    row_ind, col_ind = (robo_turn ? robo_santa : santa).to_a

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

    grid[[row_ind, col_ind]] ||= 0
    grid[[row_ind, col_ind]] += 1

    this_santa = robo_turn ? robo_santa : santa
    this_santa[:row_ind] = row_ind
    this_santa[:col_ind] = col_ind
    robo_turn = !robo_turn
  end
  puts grid.values.length
end
