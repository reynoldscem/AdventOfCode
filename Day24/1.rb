#!/usr/bin/ruby

def set_diff(s1, s2)
  s1 - s2 | s2 - s1
end

def elements_to_reach_sum(array, limit)
  (1..array.length).each do |n|
    return n if array.take(n).reduce(:+) >= limit
  end
end

def choice_for_n_bins(presents, n)
  return presents if n == 1
  presents_total_weight = presents.reduce(:+)
  desired_weight = presents_total_weight / n

  max = elements_to_reach_sum(presents, desired_weight)
  min = elements_to_reach_sum(presents.reverse, desired_weight)

  (min..max).lazy.map do |count|
    presents.combination(count).find do |combination|
      combination.reduce(:+) == desired_weight &&
        choice_for_n_bins(presents - combination, n - 1)
    end
  end.find { |x| !x.empty? }
end

begin
  presents = File.readlines(ARGV[0]).map(&:to_i)
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  puts choice_for_n_bins(presents, 4).reduce(:*)
end
