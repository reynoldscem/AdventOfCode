#!/usr/bin/ruby

def parseRule(gates, rule)
  # NOT
  if rule[0].length == 2
    ans = ~gates[rule[0][1]] & 65535
    gates[rule[1]] = ans;
  end

  case rule[0][1]
  when "LSHIFT"
    gates[rule[1]] = gates[rule[0][0]] << rule[0][2].to_i
    gates[rule[1]] = gates[rule[1]] & 65535
  when "RSHIFT"
    gates[rule[1]] = gates[rule[0][0]] >> rule[0][2].to_i
  when "AND"
    left = if gates.has_key?(rule[0][0])
      gates[rule[0][0]]
    else
      rule[0][0].to_i
    end
    right = if gates.has_key?(rule[0][2])
      gates[rule[0][2]]
    else
      rule[0][2].to_i
    end
    gates[rule[1]] = left & right
  when "OR"
    left = if gates.has_key?(rule[0][0])
      gates[rule[0][0]]
    else
      rule[0][0].to_i
    end
    right = if gates.has_key?(rule[0][2])
      gates[rule[0][2]]
    else
      rule[0][2].to_i
    end
    gates[rule[1]] = left | right
  end
end

def getNextRoundIndices(rules, gates)
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

gates = Hash.new

rules = input.map {|rule| rule.split("->").map(&:strip)}.map{|rule| [rule[0].split, rule[1]]}
baseRuleIndices = rules.each_index.select do |index|
  rule = rules[index]
  rule[0].length == 1 && rule[0][0].match(/[0-65535]/)
end

baseRuleIndices.each do |index|
  rule = rules[index]
  rules[index] = nil
  gates[rule[1]] = rule[0][0].to_i
end

rules.compact!

# [] on the LHS indicates that it's a base rule too
while (nextRound = getNextRoundIndices(rules, gates)).length > 0
  nextRound.each do |index|
    rule = rules[index]
    rules[index] = nil
    parseRule(gates, rule)
  end
  rules.compact!
end
