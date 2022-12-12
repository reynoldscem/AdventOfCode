#!/usr/bin/ruby

def parse_rule(gates, rule)

  # Assign
  if rule[0].length == 1
    gates[rule[1]] = gates[rule[0][0]].to_i
    return
  end

  # NOT
  if rule[0].length == 2
    ans = (~gates[rule[0][1]]) & 65_535
    gates[rule[1]] = ans
    return
  end

  case rule[0][1]
  when 'LSHIFT'
    gates[rule[1]] = gates[rule[0][0]] << rule[0][2].to_i
    gates[rule[1]] = gates[rule[1]] & 65_535
  when 'RSHIFT'
    gates[rule[1]] = gates[rule[0][0]] >> rule[0][2].to_i
  when 'AND'
    left =
      if gates.key?(rule[0][0])
        gates[rule[0][0]]
      else
        rule[0][0].to_i
      end
    right =
      if gates.key?(rule[0][2])
        gates[rule[0][2]]
      else
        rule[0][2].to_i
      end
    gates[rule[1]] = left & right
  when 'OR'
    left =
      if gates.key?(rule[0][0])
        gates[rule[0][0]]
      else
        rule[0][0].to_i
      end
    right =
      if gates.key?(rule[0][2])
        gates[rule[0][2]]
      else
        rule[0][2].to_i
      end
    gates[rule[1]] = left | right
  end
end

def get_next_indices(rules, gates)
  # Remove all opcodes and constants from LHS of rules
  # Retain just LHS operands
  lhs = rules.map do |rule|
    rule[0].reject do |token|
      token.match(/[RSHIFT|LSHIFT|OR|NOT|AND\d]/)
    end
  end

  # Get indices of those whose sources we have already evaluated
  lhs.each_index.select do |index|
    item = lhs[index]
    (item | gates.keys).length == gates.keys.length
  end
end

input = File.open(ARGV[0]).read.split("\n")

gates = {}

rules = input.map { |rule| rule.split("->").map(&:strip) }.map do |rule|
  [rule[0].split, rule[1]]
end

base_rule_indices = rules.each_index.select do |index|
  rule = rules[index]
  rule[0].length == 1 && rule[0][0].match(/[0-65535]/)
end

base_rule_indices.each do |index|
  rule = rules[index]
  rules[index] = nil
  gates[rule[1]] = rule[0][0].to_i
end

rules.compact!

while (next_round = get_next_indices(rules, gates)).length > 0
  next_round.each do |index|
    rule = rules[index]
    rules[index] = nil
    parse_rule(gates, rule)
  end
  rules.compact!
end

puts gates["a"]
