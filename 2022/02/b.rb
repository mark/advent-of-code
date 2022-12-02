Scoring = {
  'A X' => 3, # lost + picked scissors
  'A Y' => 4, # draw + picked rock
  'A Z' => 8, # win + picked paper

  'B X' => 1, # lost + picked rock
  'B Y' => 5, # draw + picked paper
  'B Z' => 9, # win + picked scissors

  'C X' => 2, # lost + picked paper
  'C Y' => 6, # draw + picked scissors
  'C Z' => 7  # win + picked rock
}

# A = rock, B = paper, C = scissors (opponent)
# X = lose, Y = draw, Z = win (outcome)

lines = File.readlines('./input.txt').map(&:chomp)

expected = lines.map { |l| Scoring[l] }.sum

puts "Expected score = #{expected}"