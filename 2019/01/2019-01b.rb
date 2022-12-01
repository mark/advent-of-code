def fuel_for_module(weight)
  last_fuel = weight / 3 - 2
  fuel_total = 0

  while last_fuel > 0
    fuel_total += last_fuel
    last_fuel = last_fuel / 3 - 2
  end

  return fuel_total
end

mods = File.readlines('./2019-01-input.txt')
# mods = ["100756"]

total = mods.map { |line| fuel_for_module(line.to_i) }.sum

puts "fuel total = #{ total }"