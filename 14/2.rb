#!/usr/bin/ruby

def timeForReindeer(reindeer, totalTime)
  completeCycles = totalTime / (reindeer.duration + reindeer.rest)
  remainingTime = [totalTime % (reindeer.duration + reindeer.rest), reindeer.duration].min
  completeCycles * reindeer.speed * reindeer.duration + remainingTime * reindeer.speed
end

begin
  input = File.open(ARGV[0]).read.split("\n").map(&:split)
  duration = ARGV[1].to_i
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  Reindeer = Struct.new(:name, :speed, :duration, :rest, :points)

  reindeers = input.map do |line|
    Reindeer.new(line[0], line[3].to_i, line[6].to_i, line[-2].to_i, 0)
  end

  (1..duration).each do |duration|
    reindeerTimes = reindeers.map do |reindeer|
      timeForReindeer(reindeer, duration)
    end

    sorted = Hash[reindeers.zip(reindeerTimes)].sort_by{|_,k|k}

    bests = sorted.select{|reindeer| reindeer[1] == sorted.last[1]}

    bests.each do |reindeer|
      reindeer[0].points += 1
    end
  end

  puts reindeers.sort_by {|reindeer| reindeer.points}.last.points
end
