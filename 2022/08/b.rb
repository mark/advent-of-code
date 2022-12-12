Heights = File.readlines('./input.txt')
              .map { |line| line.chomp.split('').map(&:to_i) }

Size = Heights.length

Senic = Array.new(Size) { Array.new(Size) { 0 } }

def check_visibilities(x, y, dx, dy)
  starting_height = Heights[y][x]
  count = 0
  x += dx
  y += dy
  while x >= 0 && y >= 0 && y < Size && x < Size
    count += 1
    height = Heights[y][x]
    if height >= starting_height
      return count
    end
    x += dx
    y += dy
  end
  return count
end

def check_all_visiblities
  Size.times do |x|
    Size.times do |y|
      Senic[y][x] = [
        check_visibilities(x, y, 1, 0),
        check_visibilities(x, y, -1, 0),
        check_visibilities(x, y, 0, 1),
        check_visibilities(x, y, 0, -1)
      ].inject(:*)
    end
  end
end


def display_visibilities(x, y)
  right = check_visibilities(x, y, 1, 0)
  left = check_visibilities(x, y, -1, 0)
  down = check_visibilities(x, y, 0, 1)
  up = check_visibilities(x, y, 0, -1)

  puts "At (#{x}, #{y}), height = #{Heights[y][x]}"
  puts "^#{up} >#{right} <#{left} v#{down}"
end

# display_visibilities(2, 3)

check_all_visiblities
best = Senic.flatten.max

puts "Best senic score = #{best}"