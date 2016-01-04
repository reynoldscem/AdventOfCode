#!/usr/bin/ruby

def valid_path?(adj_mat, path, cities_to_indices)
  (1...(path.length)).each do |index|
    source_city = cities_to_indices[path[index - 1]]
    dest_city = cities_to_indices[path[index]]
    return false if adj_mat[source_city][dest_city].zero?
  end
  true
end

def path_length(adj_mat, path, cities_to_indices)
  length = 0
  (1...(path.length)).each do |index|
    source_city = cities_to_indices[path[index - 1]]
    dest_city = cities_to_indices[path[index]]
    length += adj_mat[source_city][dest_city]
  end
  length
end

begin
  input = File.open(ARGV[0]).read.split("\n")
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  replacements =
    [
      [/ to /, ' '],
      [/\d/, ''],
      [/=/, '']
    ]
  cities = input.join
  replacements.each do |pair|
    cities.gsub!(pair[0], pair[1])
  end
  cities = cities.split.uniq.sort
  cities_to_indices = Hash[cities.map.with_index.to_a]
  adj_mat = Array.new(cities.length) { Array.new(cities.length) { 0 } }
  replacements.delete_at(1)
  tuples = input.map do |line|
    replacements.each do |pair|
      line.gsub!(pair[0], pair[1])
    end
    line.split
  end
  tuples.each do |tuple|
    first_city = cities_to_indices[tuple[0]]
    second_city = cities_to_indices[tuple[1]]
    distance = tuple[2].to_i
    adj_mat[first_city][second_city] = distance
    adj_mat[second_city][first_city] = distance
  end
  # O(|cities|!), but who cares?
  possible_paths = cities.permutation.select do |path|
    valid_path?(adj_mat, path, cities_to_indices)
  end
  best = Hash[possible_paths.map do |path|
    path_length(adj_mat, path, cities_to_indices)
  end.zip(possible_paths)].max
  puts 'Best path is:'
  best[1].each { |city| print(city, ' ') }
  puts
  print('Length ', best[0])
  puts
end
