#!/usr/bin/ruby

def cals(ingredients, amounts)
  ingredients = ingredients.clone
  ingredients.keys.each do |name|
    ingredients[name] = ingredients[name].values[-1] * amounts[name]
  end
  ingredients.values.reduce(:+)
end

def scale_ingredients(ingredient, amount)
  ingredient.values[0...-1].map { |e| e * amount }
end

def score(ingredients, amounts)
  ingredients = ingredients.clone
  ingredients.keys.each do |name|
    ingredients[name] =
      scale_ingredients(ingredients[name], amounts[name])
  end
  ingredients.values.transpose.map do |set|
    sum = set.reduce(:+)
    sum < 0 ? 0 : sum
  end.reduce(:*)
end

begin
  input = File.readlines(ARGV[0])
rescue
  puts 'Valid input file from AdventOfCode required as first argument.'
else
  Ingredient = Struct.new(:capacity, :durability, :flavour, :texture, :calories)
  ingredients = {}
  amounts = {}
  tokens = input.map { |line| line.tr(',:', '').split }
  tokens.each do |entry|
    values = entry.select { |token| token.match(/-?\d+/) }.map(&:to_i)
    ingredients[entry[0]] = Ingredient.new(*values)
    amounts[entry[0]] = 100 / input.length
  end
  loop do
    old_score = score(ingredients, amounts)
    ingredients_to_change = nil
    valid = {}
    keys = ingredients.keys
    keys.product(keys).select { |e| e[0] != e[1] }.each do |key_pair|
      tmp = amounts.clone
      tmp[key_pair[0]] += 1
      tmp[key_pair[1]] -= 1
      this_score = score(ingredients, tmp)
      valid[key_pair] = cals(ingredients, tmp) <= 500
      if this_score > old_score && valid[key_pair]
        old_score = this_score
        ingredients_to_change = key_pair
      end
    end
    break if ingredients_to_change.nil?
    amounts[ingredients_to_change[0]] += 1
    amounts[ingredients_to_change[1]] -= 1
  end

  puts score(ingredients, amounts)

end
