input = File.readlines('./2021-07-input.txt')[0].split(',').map(&:to_i)

min = input.min
max = input.max

fuel = (min..max).map { |n| [input.map { |i| (n-i).abs }.sum, n] }

best = fuel.min

puts "Best choice = #{best[1]}, fuel used = #{best[0]}"

sorted = input.sort

puts "Median = #{ (sorted[499] + sorted[500])/2}"