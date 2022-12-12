#!/usr/bin/ruby

replacements =
  { 'through ' => '', 'turn ' => '', ',' => ' ' }

input = File.open(ARGV[0]).read.split("\n").map do |instruction|
  replacements.each { |h, k| instruction.gsub!(h, k) }
  instruction
end

@light_grid = Array.new(1000) { Array.new(1000) { false } }

def get_indices(start_row, start_col, end_row, end_col)
  (start_row..end_row).to_a.product((start_col..end_col).to_a)
end

def toggle(indices)
  get_indices(*indices).each do |light|
    @light_grid[light[0]][light[1]] = !@light_grid[light[0]][light[1]]
  end
end

def off(indices)
  get_indices(*indices).each do |light|
    @light_grid[light[0]][light[1]] = false
  end
end

def on(indices)
  get_indices(*indices).each do |light|
    @light_grid[light[0]][light[1]] = true
  end
end

input.each do |instruction|
  tokens = instruction.split
  send(tokens.first, tokens[1..4].map(&:to_i))
end
puts @light_grid.flatten.count { |x| x }
