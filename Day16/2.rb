#!/usr/bin/ruby
require 'pry'

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

cats_and_trees = %w(cats, trees)
poms_and_fish = %w(pomeranians, goldfish)

def value_compare(a, b, symbol)
  a.zip(b).each do |pair|
    return false unless pair[0].send(symbol, pair[1])
  end
  true
end

def lesser(a, b)
  value_compare(a, b, :<)
end

def greater(a, b)
  value_compare(a, b, :>)
end

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
    my_poms_and_fish = shared & poms_and_fish
    my_cats_and_trees = shared & cats_and_trees
    shared = shared - poms_and_fish - cats_and_trees
    unless tuple.values_at(*shared) == tape.values_at(*shared) &&
           greater(tuple.values_at(*my_cats_and_trees),
                   tape.values_at(*my_cats_and_trees)) &&
           lesser(tuple.values_at(*my_poms_and_fish),
                  tape.values_at(*my_poms_and_fish))
      next
    end
    tuple
  end
  aunt_index = correct_aunt.index do |aunt|
    !aunt.nil?
  end
  puts aunt_index + 1
end
