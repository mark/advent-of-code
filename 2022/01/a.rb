lines = File.readlines('./input.txt').map(&:chomp)

max_calories = 0
current = 0

lines.each do |line|
  if line.to_i == 0
    if current > max_calories
      max_calories = current
    end
    current = 0
  else
    current += line.to_i
  end
end

puts "Max calories = #{max_calories}"

