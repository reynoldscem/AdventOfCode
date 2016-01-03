#!/usr/bin/ruby
require 'pry'

begin
  instructions = File.open(ARGV[0]).read.split("\n").map{|item| item.gsub(/,/,"").split }
  verbose = ARGV[1] == "-v"
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  pCounter = 0
  regBank = Array.new(2){0}
  regBank[0] = 1
  while pCounter < instructions.length
    cir = instructions[pCounter]
    puts "Read: " + cir.join(' ') if verbose
    case cir[0]
    when "jmp"
      pCounter += (cir[1].to_i - 1)
    when "jio"
      pCounter += (cir[2].to_i - 1) if (regBank[cir[1].ord-97]) == 1
    when "jie"
      pCounter += (cir[2].to_i - 1) if (regBank[cir[1].ord-97] % 2).zero?
    when "inc"
      regBank[(cir[1].ord-97)] += 1
    when "tpl"
      regBank[(cir[1].ord-97)] *= 3
    when "hlf"
      regBank[(cir[1].ord-97)] /= 2
    end
    pCounter += 1
    if verbose
      puts "pCounter: " + pCounter.to_s
      puts "A: ", regBank[0]
      puts "B: ", regBank[1]
      puts
    end
  end
  puts "Terminated" if verbose
end
