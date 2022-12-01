input = File.readlines('./2021-11-input.txt').map { |line| line.chomp.split('').map(&:to_i) }

flash_count = 0

def print_board(board)
  # puts board.length
  Height.times do |y|
    puts board[y * Width, Width].join
  end

  puts
end

Width  = input[0].length
Height = input.length

current = input.flatten

def each_cell(board)
  Height.times do |y|
    Width.times do |x|
      yield get(board, x, y), x, y
    end
  end
end

def each_neighbor(x, y)
  [-1, 0, 1].each do |dx|
    [-1, 0, 1].each do |dy|
      if dx != 0 || dy != 0
        x1 = x + dx
        y1 = y + dy

        if x1 >= 0 && y1 >= 0 && x1 < Width && y1 < Height
          yield x1, y1
        end
      end
    end
  end
end

def get(board, x, y)
  board[y * Width + x]
end

def set(board, x, y, to)
  board[y * Width + x] = to
end

fire_count = 0

puts "Before any steps:"
print_board(current)

all_flashed = false
round = 0

while ! all_flashed
  round += 1
  next_state = Array.new(Width * Height) { 0 }
  did_fire = Array.new(Width * Height) { false }

  each_cell(current) do |cell, x, y|
    set(next_state, x, y, cell+1)
  end

  any_fired = true

  while any_fired
    # print_board(next_state)

    any_fired = false

    each_cell(next_state) do |cell, x, y|
      if cell > 9 && ! get(did_fire, x, y)
        # puts "Fire at (#{x},#{y})"
        fire_count += 1
        set(did_fire, x, y, true)
        each_neighbor(x, y) do |x1, y1|
          set(next_state, x1, y1, get(next_state, x1, y1) + 1)
        end
        any_fired = true
      end
    end
  end

  each_cell(did_fire) do |fired, x, y|
    set(next_state, x, y, 0) if fired
  end

  all_flashed = did_fire.all?
  current = next_state

  puts "After step #{round}"
  print_board(current)
  puts "Total flash count = #{ fire_count }\n"
end

