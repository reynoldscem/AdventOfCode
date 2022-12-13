#!/usr/bin/ruby

require 'pry'

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
    # puts set
    sum = set.reduce(:+)
    # puts sum
    # puts
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
  old_score = 0
  loop do
    puts old_score
    ingredients_to_change = nil
    keys = ingredients.keys
    keys.product(keys).select { |e| e[0] != e[1] }.each do |key_pair|
      tmp = amounts.clone
      tmp[key_pair[0]] += 1
      tmp[key_pair[1]] -= 1
      this_score = score(ingredients, tmp)

      if this_score > old_score and cals(ingredients, tmp) == 500
        old_score = this_score
        ingredients_to_change = key_pair
        puts cals(ingredients, tmp)
        puts tmp
      end
    end

    if ingredients_to_change.nil?
      key = amounts.keys[rand(amounts.count)]
      amounts[key] += rand(101)

      sum = amounts.values.reduce(:+)
      amounts = amounts.map {|key, amount| [key, 100 * amount / sum] }.to_h

      offset = 100 - amounts.values.sum

      key = amounts.keys[rand(amounts.count)]
      amounts[key] += offset
      next
    end
    

    tmp_amounts = amounts.clone
    loop do
      tmp_amounts[ingredients_to_change[0]] += 1
      tmp_amounts[ingredients_to_change[1]] -= 1

      if !(0..100).include? tmp_amounts[ingredients_to_change[0]]
        break
      end
      if !(0..100).include? tmp_amounts[ingredients_to_change[1]]
        break
      end

      if cals(ingredients, tmp_amounts) == 500
          old_score = score(ingredients, tmp_amounts)
          amounts = tmp_amounts
          puts old_score
          break
      end

    end
  end

  puts score(ingredients, amounts)

end
