#!/usr/bin/ruby
require 'pry'

tape =
  Hash[
    *
    """
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
    """
    .gsub(/:/,'')
    .split
    .map.with_index(1) do |e, i|
      (i % 2).zero? ? e.to_i : e
    end
    ]

catsNTrees = ["cats", "trees"]
pomsNfish = ["pomeranians", "goldfish"]

def valueCompare(a, b, symbol)
  a.zip(b).each do |pair|
    return false if !pair[0].send(symbol, pair[1])
  end
  true
end

def lesser(a, b)
  valueCompare(a, b, :<)
end

def greater(a, b)
  valueCompare(a, b, :>)
end

begin
  input = File.readlines(ARGV[0])
rescue
  puts "Oops"
else
    puts(input.map do |line|
      Hash[
        line.strip
          .split(": ",2)[1]
          .split(', ')
          .map do |tuple|
            tuple = tuple.split(': ')
            tuple[1] = tuple[1].to_i
            tuple
        end
      ]
    end
    .map do |tuple|
    shared = tuple.keys & tape.keys
    myPomsNFish = shared & pomsNfish
    mycatsNTrees = shared & catsNTrees
    shared = shared - pomsNfish - catsNTrees
    if tuple.values_at(*shared) == tape.values_at(*shared) &&
       greater(tuple.values_at(*mycatsNTrees), tape.values_at(*mycatsNTrees)) &&
       lesser(tuple.values_at(*myPomsNFish), tape.values_at(*myPomsNFish))
      tuple
    else
      nil
    end
  end
  .index do |aunt|
    !aunt.nil?
  end + 1)
end
