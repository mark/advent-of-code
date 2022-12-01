require 'pp'
require 'set'
rules_raw = File.readlines('./2020-07-input.txt').map(&:strip)

TOP_LEVEL = /^(.+) bags contain (.+)[.]$/
BOTTOM_LEVEL = /^(\d+) (.+) bags?/
LEAF = "no other bags"

def parse_rules(rules, rule)
  if rule =~ TOP_LEVEL
    key    = $1
    values = {}

    if $2 != LEAF
      values_raw = $2.split(', ')
      values_raw.each do |value_raw|
        if value_raw =~ BOTTOM_LEVEL
          values[$2] = $1.to_i
        else
          raise "INVALID BREAKDOWN: #{value_raw} for #{ key }"
        end
      end
    end

    rules[key] = values
  else
    raise "INVALID RULE #{ rule }"
  end
end

rules = {}

rules_raw.each { |rule_raw| parse_rules(rules, rule_raw) }

pp rules

good_bags = ["shiny gold"]
old_good_count = good_count = 0

loop do
  rules.each do |key, values|
    if (values.keys & good_bags).length > 0
      good_bags << key
    end
  end

  good_bags = good_bags.uniq
  old_good_count, good_count = good_count, good_bags.length

  break if old_good_count == good_count
end

puts good_bags.inspect
puts good_bags.length

heights = {}

loop do
  rules.each do |key, values|
    if values.keys.all? { |v| heights[v] }
      heights[key] = values.map { |k, v| v * heights[k] }.sum + 1
    end
  end

  break if heights["shiny gold"]
end

pp heights

puts heights["shiny gold"]
