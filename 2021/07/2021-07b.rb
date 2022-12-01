input = File.readlines('./2021-07-input.txt')[0].split(',').map(&:to_i)

min = input.min
max = input.max

def triangle(n)
  n * (n+1) / 2
end

fuel = (min..max).map { |n| [input.map { |i| triangle (n-i).abs }.sum, n] }.sort

best = fuel.sort[0]

puts "Best choice = #{best[1]}, fuel used = #{best[0]}"

mean = input.sum.to_f / input.length

puts "Mean = #{ mean }"

10.times do |i|
  puts "choice = #{fuel[i][1]}, fuel used = #{fuel[i][0]}"
end
