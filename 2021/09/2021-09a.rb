input = File.readlines('./2021-09-input.txt').map { |row| row.chomp.split('').map(&:to_i) }

# puts input.inspect

def min_neighbor(board, x, y)
  neighbors = []
  neighbors << board[y][x-1] if x > 0
  neighbors << board[y][x+1] if x < board[0].length-1
  neighbors << board[y-1][x] if y > 0
  neighbors << board[y+1][x] if y < board.length-1
  neighbors.min
end

risks = []

input.length.times do |y|
  input[0].length.times do |x|
    at = input[y][x]
    min = min_neighbor(input, x, y)
    puts "At (#{x},#{y}), board = #{at}, min neighbor = #{min}" if at < min
    risks << (at+1) if at < min
  end
end

puts "Risk sum = #{risks.sum}"