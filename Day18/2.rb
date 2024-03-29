#!/usr/bin/ruby

@lim = 100

def disp_lights(lights, clear=true)
  system('clear') if clear
  lights.each do |row|
    row = row.map(&:to_s).join.tr('0', '.').tr('1', '#')
    puts row
  end
end

def in_bounds(row, col)
  row >= 0 && row < @lim && col >= 0 && col < @lim
end

def get_neighbours(row, col)
  modifier = ->(val) { [-1, 0, 1].map { |e| e + val } }
  row_mod = modifier.call(row)
  col_mod = modifier.call(col)
  row_mod.product(col_mod) - [[row, col]]
end

def next_state(lights, row, col)
  neighbours = get_neighbours(row, col)
  neighbour_states =
    neighbours.map do |pair|
      in_bounds(*pair) ? lights[pair[0]][pair[1]] : 0
    end
  sum = neighbour_states.reduce(:+)
  sum == 3 || (lights[row][col] == 1 ? sum == 2 : false)
end

begin
  input = File.read(ARGV[0])
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  lights =
    input.gsub(/#/, '1').gsub(/\./, '0').split.map do |line|
      line.split('').map(&:to_i)
    end
  lights[0][0] = 1
  lights[@lim - 1][@lim - 1] = 1
  lights[0][@lim - 1] = 1
  lights[@lim - 1][0] = 1
  puts("Initial")
  disp_lights(lights, false)
  puts

  (1..100).each do |steps|
    last_epoch = Marshal.load(Marshal.dump(lights))
    (0...@lim).each do |row|
      (0...@lim).each do |col|
        lights[row][col] = next_state(last_epoch, row, col) ? 1 : 0
      end
    end
    lights[0][0] = 1
    lights[@lim - 1][@lim - 1] = 1
    lights[0][@lim - 1] = 1
    lights[@lim - 1][0] = 1

    puts("After #{steps} steps")
    disp_lights(lights, false)
    puts
  end
  puts lights.flatten.reduce(:+)
end
