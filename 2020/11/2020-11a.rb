board = File.readlines('./2020-11-input.txt').map { |line| line.chomp.split('') }

def print_board(board)
  board.each { |row| puts row.join }
end

def chomp(min, value, max)
  value > max ? max : (value < min ? min : value)
end

def chomp_range(min, left, right, max)
  chomp(min, left, max) .. chomp(min, right, max)
end

def count_occupied_around(board, x, y)
  occupied_count = 0

  xrange = chomp_range(0, x-1, x+1, board[0].length-1)
  yrange = chomp_range(0, y-1, y+1, board.length-1)

  yrange.each do |y1|
    xrange.each do |x1|
      # puts "(#{x},#{y}) eval (#{x1},#{y1}) see #{board[y1][x1]}"
      occupied_count += 1 if (x != x1 || y != y1) && board[y1][x1] == '#'
    end
  end

  occupied_count
end

def next_state(current)
  current.map.with_index do |row, y|
    row.map.with_index do |cell, x|
      if cell == '.'
        '.'
      elsif cell == '#'
        count = count_occupied_around(current, x, y)
        # puts "(#{x},#{y}) -> #{ count }"

        count >= 4 ? 'L' : '#'
      elsif cell == 'L'
        count = count_occupied_around(current, x, y)
        count == 0 ? '#' : 'L'
      else
        '!'
      end
    end
  end
end

def occupied_count(board)
  board.map { |row| row.count { |cell| cell == '#' } }.sum
end

before = board
after  = nil
done = false

while ! done
  puts "Update"
  after = next_state(before)
  done = before == after
  before = after
end

puts "Before:"
puts
print_board(board)

puts
puts "After, occupied count = #{ occupied_count(after) }"
puts
print_board(after)