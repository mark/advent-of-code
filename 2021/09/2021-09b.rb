require 'set'
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

# risks = []
basins = Array.new(input.length) { Array.new(input[0].length) { 0 }}
floods = []

input.length.times do |y|
  input[0].length.times do |x|
    at = input[y][x]
    min = min_neighbor(input, x, y)
    # puts "At (#{x},#{y}), board = #{at}, min neighbor = #{min}" if at < min
    # risks << (at+1) if at < min
    if at < min
      floods << [x,y]
      basins[y][x] = floods.length
    elsif at == 9
      basins[y][x] = -1
    end
  end
end

puts floods.length
basin_count = floods.length

while floods.length > 0
# 2.times do
  x, y = *floods.pop
  at = basins[y][x]
  # puts "Flooding from (#{x}, #{y}) = #{ at }"
  [[x-1,y], [x+1,y], [x,y-1], [x,y+1]].
    select { |x, y| x >= 0 && x < basins[0].length && y >= 0 && y < basins.length }.
    each do |x1, y1|
      new_at = basins[y1][x1]
      if new_at == -1
        # ridge, do nothing
      elsif new_at == 0
        # Flood to
        basins[y1][x1] = at
        floods << [x1, y1]
      elsif new_at == at
        # Already flooded, do nothing
      else
        puts "Flood (#{x},#{y}) = #{at} to (#{x1},#{y1}) = #{new_at} failed"
      end
    end
end

# puts "Risk sum = #{risks.sum}"
Mapping = ['.'] + (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a) * 10   + ['#']

counts = Array.new(basin_count + 1) { 0 }

input.length.times do |y|
  input[0].length.times do |x|
    print Mapping[basins[y][x]]
    counts[basins[y][x]] += 1 if basins[y][x] != -1
    # if lows.include?([x,y])
    #   print '*'
    # elsif input[y][x] == 9
    #   print '#'
    # else
    #   print ' '
    # end
  end
  puts
end

bigs = counts.sort.reverse

puts "Product = #{ bigs[0] * bigs[1] * bigs[2] }"