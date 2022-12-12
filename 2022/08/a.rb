Heights = File.readlines('./input.txt')
              .map { |line| line.chomp.split('').map(&:to_i) }

Size = Heights.length

Visible = Array.new(Size) { Array.new(Size) { false } }

def check_visibilities(x, y, dx, dy)
  cur_height = -1
  while x >= 0 && y >= 0 && y < Size && x < Size
    height = Heights[y][x]
    if height > cur_height
      Visible[y][x] = true
      cur_height = height
    end
    x += dx
    y += dy
  end
end

def count
  Visible.map { |row| row.count { |cell| cell }}.sum
end

def check_all_visiblities
  Size.times do |idx|
    check_visibilities(0, idx, 1, 0)
    check_visibilities(Size-1, idx, -1, 0)
    check_visibilities(idx, 0, 0, 1)
    check_visibilities(idx, Size-1, 0, -1)
  end
end

check_all_visiblities

puts "Total count = #{count}"
