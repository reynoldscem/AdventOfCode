#!/usr/bin/ruby

def complete_cycles(reindeer, total_time)
  total_time / (reindeer.duration + reindeer.rest)
end

def remaining_time(reindeer, total_time)
  [total_time % (reindeer.duration + reindeer.rest), reindeer.duration].min
end

def time_for_reindeer(reindeer, total_time)
  complete_cycles(reindeer, total_time) * reindeer.speed * reindeer.duration +
    remaining_time(reindeer, total_time) * reindeer.speed
end

begin
  input = File.open(ARGV[0]).read.split("\n").map(&:split)
  duration = ARGV[1].to_i
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  Reindeer = Struct.new(:name, :speed, :duration, :rest)

  reindeers = input.map do |line|
    Reindeer.new(line[0], line[3].to_i, line[6].to_i, line[-2].to_i)
  end

  reindeer_times = reindeers.map do |reindeer|
    time_for_reindeer(reindeer, duration)
  end

  puts reindeer_times.max

end
