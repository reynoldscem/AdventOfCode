#!/usr/bin/ruby
require 'pry'
require 'json'

def giz_values(hash)
  values = []
  if hash.kind_of?(Array)
    hash.each { |h| values << giz_values(h) }
  elsif hash.kind_of?(Hash)
    values << hash.values.select {|v| v.kind_of?(String)}
    values << giz_values(hash.values.select {|v| v.kind_of?(Array) || v.kind_of?(Hash)})
  elsif hash.kind_of?(String)
    #values << hash
  end
  values.flatten
end

def remove_recursive(hash, valuesToRemove)
  if hash.kind_of?(Array)
    hash.each do |h|
      remove_recursive(h, valuesToRemove)
    end
  elsif hash.kind_of?(Hash)
    hash.each do |key, value|
      if value.kind_of?(Hash) && value.has_value?(valuesToRemove)
        hash.delete(key)
      elsif value.kind_of?(String) && valuesToRemove.include?(value)
        hash.delete(key)
      else
        remove_recursive(hash[key], valuesToRemove)
      end
    end
  end
end

begin
  str = File.open(ARGV[0]).read.chomp
rescue
  puts "Valid input file from AdventOfCode required as first argument."
else
  data = JSON.parse(str)
  remove_recursive(data, "red")
  binding.pry
  str = data.to_json
  puts str.scan(/-*\d+/).map(&:to_i).reduce(:+)
end
