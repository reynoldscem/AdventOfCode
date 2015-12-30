#!/usr/bin/ruby
require 'pry'
require 'set'

begin
  input = File.readlines(ARGV[0])
rescue
  puts "Oops"
else
  molecule = input[-1].chomp.scan(/[A-Z][a-z]?/)
  replacements =
    Hash[
      input[0,input.length-2].map do |e|
        e.chomp.split(" => ")
      end
      .group_by(&:first)
      .map do |k,v| 
        [k,v.map(&:last)]
      end
    ]
  modifications = Set.new
  molecule.each_with_index do |token, index|
    subs = replacements[token]
    next if subs.nil?
    subs.each do |replacement|
      deepcopy = molecule.clone
      deepcopy[index] = replacement
      modifications << deepcopy.join
    end
  end
  puts modifications.length
end
