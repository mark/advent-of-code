require 'set'

Steps = {
  'L' => [-1, 0],
  'R' => [ 1, 0],
  'U' => [0,  1],
  'D' => [0, -1]
}

class Node

  attr_accessor :x, :y

  def initialize
    @x = 0
    @y = 0
  end

  def toward(x2, y2)
    dx = 0
    dy = 0
    
    return if (x-x2).abs < 2 && (y-y2).abs < 2

    dx -= 1 if x - x2 > 0
    dx += 1 if x2 - x > 0
    dy -= 1 if y - y2 > 0
    dy += 1 if y2 - y > 0

    @x += dx
    @y += dy
  end
end

lines = File.readlines('./input.txt').map(&:chomp)

head = Node.new
tail = Node.new

visited = Set.new

visited << [0,0]

lines.each do |line|
  if line =~ /([LRUD]) (\d+)/
    dx, dy = Steps[$1]
    count = $2.to_i

    count.times do
      head.x += dx
      head.y += dy
      tail.toward(head.x, head.y)
      visited << [tail.x, tail.y]
      puts "Moved #{$1}, head at (#{head.x}, #{head.y}), tail at (#{tail.x}, #{tail.y})"
    end
  else
    puts "I don't understand #{line}"
  end
end

puts "Visited #{visited.size} cells"