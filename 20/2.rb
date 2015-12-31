#!/usr/bin/ruby

begin
  input = File.open(ARGV[0]).read.to_i
rescue
  puts "Oops"
else
  houses = Array.new(100_000_000){0}
  (1..(Float::INFINITY)).each do |elf|
    (elf..(50*(elf + 1))).step(elf) do |house|
      houses[house] += (elf * 11)
    end
    if houses[elf] >= input
      puts elf
      exit
    end
  end
end
