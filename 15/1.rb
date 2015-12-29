#!/usr/bin/ruby

def cals(ingredients, amounts)
  ingredients = ingredients.clone
  ingredients.keys.each do |name|
    ingredients[name] = ingredients[name].values[-1] *amounts[name]
  end
  ingredients.values.reduce(:+)
end

def score(ingredients, amounts)
  ingredients = ingredients.clone
  ingredients.keys.each do |name|
    ingredients[name] = ingredients[name].values[0...-1].map{|e|e*amounts[name]}
  end
  ingredients.values.transpose.map do |set|
    set.reduce(:+)
  end.map do |e|
    e < 0 ? 0 : e
  end.reduce(:*)
end

begin
  input = File.readlines(ARGV[0])
rescue
  puts "Oops"
else
  Ingredient = Struct.new(:capacity, :durability, :flavour, :texture, :calories)
  ingredients = Hash.new
  amounts = Hash.new
  tokens = input.map {|line| line.tr(',:','').split }
  tokens.each do |entry|
    values = entry.select {|token| token.match(/-?\d+/) }.map(&:to_i)
    ingredients[entry[0]] = Ingredient.new(*values)
    amounts[entry[0]] = 100 / input.length
  end
  loop do
    oldScore = score(ingredients, amounts)
    ingredientsToChange = nil
    valid = Hash.new
    ingredients.keys.product(ingredients.keys).select{|e| e[0] != e[1]}.each do |keyPair|
      tmp = amounts.clone
      tmp[keyPair[0]] += 1
      tmp[keyPair[1]] -= 1
      thisScore = score(ingredients, tmp)
      valid[keyPair] = cals(ingredients, tmp) <= 500
      if thisScore > oldScore && valid[keyPair]
        oldScore = thisScore
        ingredientsToChange = keyPair
      end
    end
    break if ingredientsToChange.nil?
    amounts[ingredientsToChange[0]] += 1
    amounts[ingredientsToChange[1]] -= 1
  end
  puts score(ingredients, amounts)
end
