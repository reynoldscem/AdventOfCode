#!/usr/bin/ruby
require 'pry'
require_relative 'queue.rb'

@verbose = false

Gamestate =
  Struct.new('Gamestate',
             :boss_hp, :boss_dmg,
             :player_hp, :player_mana, :player_armour,
             :effects, :player_turn, :mana_spent)
Spell = Struct.new('Spell', :name, :cost, :damage, :heal, :effect)
Effect = Struct.new('Effect', :name, :remaining, :boost, :buff, :damage)
SHIELD = Effect.new('Shield', 6, 0, 7, 0)
POISON = Effect.new('Poison', 6, 0, 0, 3)
RECHARGE = Effect.new('Recharge', 5, 101, 0, 0)
SPELLS =
  {
    'MM' => Spell.new('Magic Missle', 53, 4, 0, nil),
    'Dr' => Spell.new('Drain', 73, 2, 2, nil),
    'Sh' => Spell.new('Shield', 113, 0, 0, SHIELD),
    'Po' => Spell.new('Poison', 173, 0, 0, POISON),
    'Re' => Spell.new('Recharge', 229, 0, 0, RECHARGE)
  }

state = Gamestate.new(51, 9, 50, 500, 0, [], true, 0)

def shield_action(state, effect)
  if effect.remaining == SHIELD.remaining
    state.player_armour += SHIELD.buff
  elsif effect.remaining == 1
    state.player_armour -= SHIELD.buff
  end
end

def poision_action(state, effect)
  state.boss_hp -= POISON.damage if effect.remaining > 0
  print('Poison deals ' + POISON.damage.to_s + ' damage') if @verbose
end

def recharge_action(state, effect)
  state.player_mana += RECHARGE.boost if effect.remaining > 0
  print('Recharge provides ' + RECHARGE.boost.to_s + ' mana') if @verbose
end

def print_effect_off(effect)
  print(effect.name + ' wears off')
  print(', decreasing armour by ' + SHIELD.buff.to_s)
  puts('.')
end

def print_post_effect_status(state, effect)
  if state.boss_hp > 0
    if effect.name != 'Shield'
      print('; its ')
    else
      print("Shield's ")
    end
    puts('timer is now ' + effect.remaining.to_s + '.')
    print_effect_off effect if effect.remaining == 0
  else
    puts('. This kills the boss, and the player wins.')
  end
end

def enact_effect(state, effect)
  case effect.name
  when 'Shield'
    shield_action(state, effect)
  when 'Poison'
    poision_action(state, effect)
  when 'Recharge'
    recharge_action(state, effect)
  end
  effect.remaining -= 1
  print_post_effect_status(state, effect) if @verbose
end

def effects_handler(state)
  state.effects.delete_if do |effect|
    # binding.pry if state.boss_hp == 12
    enact_effect(state, effect)
    effect.remaining == 0
  end
end

def attack(state, spell)
  return unless state.boss_hp > 0
  if spell.nil?
    boss_dmg = state.boss_dmg - state.player_armour
    state.player_hp -= boss_dmg

    print_boss_dmg(boss_dmg, state.player_armour > 0) if @verbose
  else
    state.player_mana -= spell.cost
    state.mana_spent += spell.cost
    state.boss_hp -= spell.damage
    state.player_hp += spell.heal

    state.effects << clone(spell.effect) unless spell.effect.nil?

    print_cast spell if @verbose
  end
end

def print_state(state)
  whose_turn = (state.player_turn ? 'Player' : 'Boss')
  puts('-- ' + whose_turn + ' turn --')
  puts('- Player has ' + state.player_hp.to_s + ' hit points, ' +
    state.player_armour.to_s + ' armour, ' + state.player_mana.to_s + ' mana')
  puts('- Boss has ' + state.boss_hp.to_s + ' hit points')
end

def print_cast(spell)
  print('Player casts ' + spell.name) unless spell.nil?
  print(', dealing ' + spell.damage.to_s + ' damage') if spell.damage > 0
  print(', and healing ' + spell.heal.to_s + ' hit points') if spell.heal > 0
  puts('.')
end

def print_boss_dmg(boss_dmg, armour)
  if armour
    base_dmg = boss_dmg + SHIELD.buff
    puts('Boss attacks for ' + base_dmg.to_s + ' - ' + SHIELD.buff.to_s +
      ' = ' + boss_dmg.to_s + ' damage!')
  else
    puts('Boss attacks for ' + boss_dmg.to_s + ' damage!')
  end
end

def next_states(state)
  return [] if state.boss_hp <= 0 || state.player_hp <= 0
  next_spells(state).map do |spell|
    change_state(clone(state), spell)
  end
end

def next_spells(state)
  return [nil] unless state.player_turn
  potentialSpells = clone(SPELLS.values)
  potentialSpells.reject do |spell|
    (!spell.effect.nil? &&
      state.effects.map(&:name).include?(spell.effect.name)) ||
      spell.cost > state.player_mana
  end
end

def change_state(state, spell)
  print_state state if @verbose
  effects_handler state

  attack(state, spell)

  state.player_turn = !state.player_turn
  puts if @verbose
  state
end

def clone(obj)
  Marshal.load(Marshal.dump(obj))
end

states = Queue.new.enqueue state
best = Float::INFINITY
bestState = nil

until states.empty?
  current = states.dequeue
  next_iter = next_states current
  if next_iter.empty? && current.boss_hp <= 0 && current.player_hp > 0
    #binding.pry
    #puts current.mana_spent
    if best == nil || (current.mana_spent < best)
      best = current.mana_spent
      bestState = clone(current)
    end
    pruned_states = Queue.new
    states.store.reject { |s| s.player_hp <= 0 || s.mana_spent >= best}.each do |pruned_state|
      pruned_states.enqueue pruned_state
    end
    # binding.pry
    states = pruned_states
    next
  end

  next_iter.each do |succ|
    states.enqueue succ
  end

end
puts best
exit
binding.pry
change_state(state, clone(SPELLS['Re']))
change_state(state, nil)
change_state(state, clone(SPELLS['Sh']))
change_state(state, nil)
change_state(state, clone(SPELLS['Dr']))
change_state(state, nil)
change_state(state, clone(SPELLS['Po']))
change_state(state, nil)
change_state(state, clone(SPELLS['MM']))
change_state(state, nil)

