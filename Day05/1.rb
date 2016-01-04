#!/usr/bin/ruby

# Monkeypatch to check string is nice
class String
  def includes_pairs
    include?('ab') || include?('cd') ||
      include?('pq') || include?('xy')
  end

  def under_n_vowels(n)
    scan(/[aeiou]/).length < n
  end

  def atleast_one_repetition
    squeeze.length == length
  end

  def nice?
    !includes_pairs &&
      !under_n_vowels(3) &&
      !atleast_one_repetition
  end

  # Find out who's naughty or nice
  def check_twice
    nice? && nice?
  end
end

begin
  # Make a list
  list = File.open(ARGV[0]).read.split
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  # Check it twice
  puts list.count(&:check_twice)

  santa_clause_is_coming_to_town = true
  assert santa_clause_is_coming_to_town
end
