#!/usr/bin/ruby

tape =
  Hash[
    *
    "
      children: 3
      cats: 7
      samoyeds: 2
      pomeranians: 3
      akitas: 0
      vizslas: 0
      goldfish: 5
      trees: 3
      cars: 2
      perfumes: 1
    "
    .gsub(/:/, '')
    .split
    .map.with_index(1) do |e, i|
      (i % 2).zero? ? e.to_i : e
    end
    ]

begin
  input = File.readlines(ARGV[0])
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  aunt_hashes = input.map do |line|
    Hash[
      line.strip.split(': ', 2)[1].split(', ').map do |tuple|
        tuple = tuple.split(': ')
        tuple[1] = tuple[1].to_i
        tuple
      end
    ]
  end
  correct_aunt = aunt_hashes.map do |tuple|
    shared = tuple.keys & tape.keys
    tuple.values_at(*shared) == tape.values_at(*shared) ? tuple : nil
  end
  aunt_index = correct_aunt.index do |aunt|
    !aunt.nil?
  end
  puts aunt_index + 1
end
