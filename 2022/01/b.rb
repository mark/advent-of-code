lines = File.readlines('./input.txt').map(&:chomp)

calories = []
current = 0

lines.each do |line|
  if line.to_i == 0
    calories << current
    current = 0
  else
    current += line.to_i
  end
end

# puts "Max calories = #{max_calories}"
top_3 = calories.sort.reverse[0...3].sum
puts "Top 3 = #{top_3}"
