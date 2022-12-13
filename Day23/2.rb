#!/usr/bin/ruby

begin
  instructions =
    File.open(ARGV[0]).read.split("\n").map do |item|
      item.delete(',').split
    end
  verbose = ARGV[1] == '-v'
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  p_counter = 0
  reg_bank = [1, 0]
  while p_counter < instructions.length
    cir = instructions[p_counter]
    puts 'Read: ' + cir.join(' ') if verbose
    case cir[0]
    when 'jmp'
      p_counter += (cir[1].to_i - 1)
    when 'jio'
      p_counter += (cir[2].to_i - 1) if (reg_bank[cir[1].ord - 97]) == 1
    when 'jie'
      p_counter += (cir[2].to_i - 1) if (reg_bank[cir[1].ord - 97] % 2).zero?
    when 'inc'
      reg_bank[(cir[1].ord - 97)] += 1
    when 'tpl'
      reg_bank[(cir[1].ord - 97)] *= 3
    when 'hlf'
      reg_bank[(cir[1].ord - 97)] /= 2
    end
    p_counter += 1
    next unless verbose
    puts 'p_counter: ' + p_counter.to_s
    puts 'A: ', reg_bank[0]
    puts 'B: ', reg_bank[1]
    puts
  end
  puts 'Terminated' if verbose
end
