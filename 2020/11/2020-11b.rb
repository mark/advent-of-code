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

def look_from(board, x0, y0, dx, dy)
  x, y = x0, y0
  
  loop do
    x += dx
    y += dy

    if x < 0 || x >= board[0].length || y < 0 || y >= board.length
      return false
    elsif board[y][x] == 'L'
      return false
    elsif board[y][x] == '#'
      return true
    end
  end
end

def count_occupied_around(board, x, y)
  occupied_count = 0

  [-1, 0, 1].each do |dx|
    [-1, 0, 1].each do |dy|
      # puts "(#{x},#{y}) eval (#{x1},#{y1}) see #{board[y1][x1]}"
      occupied_count += 1 if (dx != 0 || dy != 0) && look_from(board, x, y, dx, dy)
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

        count >= 5 ? 'L' : '#'
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

puts "Before:"
puts
print_board(board)

while ! done
  # puts "Update"
  after = next_state(before)
  done = before == after
  before = after

  puts
  print_board(after)
end

puts
puts "After, occupied count = #{ occupied_count(after) }"
puts
print_board(after)