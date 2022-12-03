lines = File.readlines('./input.txt').map(&:chomp)

Priorities = ['-'] + ('a'..'z').to_a + ('A'..'Z').to_a

total = lines.map do |line|
  chars = line.split('')
  
  first = chars[0,chars.length/2]
  second = chars[chars.length/2,chars.length/2]
  common = (first & second)[0]

  Priorities.index common
end.sum

puts "Total priority = #{ total }"
