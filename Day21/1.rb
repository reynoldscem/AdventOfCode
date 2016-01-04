#!/usr/bin/ruby

@debug = false

def fight(player, boss)
  player_turn = true
  while player[:hp] > 0 && boss[:hp] > 0
    if player_turn
      damage = player[:damage] - boss[:armour]
      damage > 0 ? damage : 1
      boss[:hp] -= damage
      if @debug
        puts('Player deals ' + damage.to_s)
        puts('Boss HP: ' + boss[:hp].to_s)
        puts
      end
    else
      damage = boss[:damage] - player[:armour]
      damage > 0 ? damage : 1
      player[:hp] -= damage
      if @debug
        puts('Boss deals ' + damage.to_s)
        puts('Player HP: ' + player[:hp].to_s)
        puts
      end
    end
    player_turn = !player_turn
  end
  player[:hp] > 0
end

begin
  input = File.read(ARGV[0])
  equipment = File.readlines('equipment.txt').map(&:strip)
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  Person = Struct.new(:hp, :damage, :armour)
  Item = Struct.new(:name, :cost, :damage, :armour)
  player = Person.new(0, 0, 0)
  boss = Person.new(*input.scan(/\d+/).map(&:to_i))

  weapons = equipment[1, 5]
  armour = equipment[8, 5]
  rings = equipment[15, 6]

  weapons = weapons.map do |weapon|
    split_weapon = weapon.split
    Item.new(split_weapon[0], *split_weapon[1, 3].map(&:to_i))
  end
  armour = armour.map do |this_armour|
    split_armour = this_armour.split
    Item.new(split_armour[0], *split_armour[1, 3].map(&:to_i))
  end
  rings = rings.map do |ring|
    split_ring = ring.split
    Item.new([split_ring[0], split_ring[1]].join(' '),
             *split_ring[2, 3].map(&:to_i))
  end

  possible_rings = []
  (0..2).each do |n|
    possible_rings.concat rings.combination(n).to_a
  end
  possible_armour = []
  (0..1).each do |n|
    possible_armour.concat armour.combination(n).to_a
  end
  possible_weapon = weapons
  configurations =
    possible_armour.product(possible_weapon).product(possible_rings)
  configurations = configurations.map(&:flatten)
  configurations = configurations.sort_by do |config|
    config.reduce(0) { |a, e| a + e[:cost] }
  end

  configurations.each do |config|
    boss = Person.new(*input.scan(/\d+/).map(&:to_i))
    player[:hp] = 100
    player[:damage] = config.reduce(0) { |a, e| a + e[:damage] }
    player[:armour] = config.reduce(0) { |a, e| a + e[:armour] }
    if fight(player, boss)
      puts config.reduce(0) { |a, e| a + e[:cost] }
      exit
    end
  end

  # Initial test
  player = Person.new(8, 5, 5)
  boss = Person.new(12, 7, 2)
  if fight(player, boss)
    puts 'Player wins'
  else
    puts 'Boss wins'
  end
end
