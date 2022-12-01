f = File.readlines('./2021-03-input.txt').map(&:chomp).map { |s| s.split('') }

def most_common_bit(numbers, bit)
  ones = numbers.count { |n| n[bit] == '1' }
  zeros = numbers.length - ones

  ones > zeros ? 1 : (ones < zeros ? 0 : 1)
end

def filter_numbers(numbers, bit, toggle)
  if numbers.length == 1
    numbers[0]
  else
    mcb = most_common_bit(numbers, bit)
    mcb = 1 - mcb if toggle
    filter_numbers(numbers.select { |n| n[bit] == mcb.to_s }, bit+1, toggle)
  end
end

oxygen_rating = filter_numbers(f, 0, false).join('')
co2_rating    = filter_numbers(f, 0, true).join('')

puts "Oxygen rating = #{ oxygen_rating }, decimal = #{ oxygen_rating.to_i(2) }"
puts "CO2 rating = #{ co2_rating }, decimal = #{ co2_rating.to_i(2) }"
puts "Product = #{ oxygen_rating.to_i(2) * co2_rating.to_i(2) }"