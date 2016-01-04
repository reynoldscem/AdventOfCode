#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.to_i
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  houses = Array.new((input / 10) + 1) { 0 }
  (1..(Float::INFINITY)).each do |elf|
    (elf..(input / 10)).step(elf) do |house|
      houses[house] += (elf * 10)
    end
    if houses[elf] >= input
      puts elf
      exit
    end
  end
end
