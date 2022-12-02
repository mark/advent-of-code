Scoring = {
  'A X' => 4,
  'A Y' => 8,
  'A Z' => 3,
  'B X' => 1,
  'B Y' => 5,
  'B Z' => 9,
  'C X' => 7,
  'C Y' => 2,
  'C Z' => 6
}

# A = rock, B = paper, C = scissors (opponent)
# X = rock, Y = paper, Z = scissors (self)

lines = File.readlines('./input.txt').map(&:chomp)

expected = lines.map { |l| Scoring[l] }.sum

puts "Expected score = #{expected}"