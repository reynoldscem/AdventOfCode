#!/usr/bin/ruby

@debug = false

def fight(player, boss)
  playerTurn = true
  while player[:hp] > 0 && boss[:hp] > 0
    if playerTurn
      damage = player[:damage] - boss[:armour]
      damage > 0 ? damage : 1
      boss[:hp] -= damage
      if @debug
        puts("Player deals " + damage.to_s)
        puts("Boss HP: " + boss[:hp].to_s)
        puts
      end
    else
      damage = boss[:damage] - player[:armour]
      damage > 0 ? damage : 1
      player[:hp] -= damage
      if @debug
        puts("Boss deals " + damage.to_s)
        puts("Player HP: " + player[:hp].to_s)
        puts
      end
    end
    playerTurn = !playerTurn
  end
  player[:hp] > 0
end

begin
  input = File.read(ARGV[0])
  equipment = File.readlines("equipment.txt").map(&:strip)
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  Person = Struct.new(:hp, :damage, :armour)
  Item = Struct.new(:name, :cost, :damage, :armour)
  player = Person.new(0, 0, 0)
  boss = Person.new(*input.scan(/\d+/).map(&:to_i))

  weapons = equipment[1,5]
  armour = equipment[8,5]
  rings = equipment[15,6]

  weapons = weapons.map do |weapon|
    splitWeapon = weapon.split
    Item.new(splitWeapon[0], *splitWeapon[1,3].map(&:to_i))
  end
  armour = armour.map do |armour|
    splitArmour = armour.split
    Item.new(splitArmour[0], *splitArmour[1,3].map(&:to_i))
  end
  rings = rings.map do |ring|
    splitRing = ring.split
    Item.new([splitRing[0], splitRing[1]].join(' '), *splitRing[2,3].map(&:to_i))
  end

  possibleRings = []
  (0..2).each do |n|
    possibleRings.concat rings.combination(n).to_a
  end
  possibleArmour = []
  (0..1).each do |n|
    possibleArmour.concat armour.combination(n).to_a
  end
  possibleWeapon = weapons
  configurations = possibleArmour.product(possibleWeapon).product(possibleRings)
  configurations = configurations.map do |config|
    config.flatten
  end
  configurations = configurations.sort_by do |config|
    config.reduce(0) {|acc, e| acc += e[:cost]}
  end

  configurations.each do |config|
    boss = Person.new(*input.scan(/\d+/).map(&:to_i))
    player[:hp] = 100
    player[:damage] = config.reduce(0){|acc, e| acc += e[:damage]}
    player[:armour] = config.reduce(0){|acc, e| acc += e[:armour]}
    if fight(player, boss)
      puts config.reduce(0){|acc, s| acc += s[:cost]}
      exit
    end
  end

  # Initial test
  player = Person.new(8,5,5)
  boss = Person.new(12,7,2)
  if fight(player,boss)
    puts "Player wins"
  else
    puts "Boss wins"
  end
end
