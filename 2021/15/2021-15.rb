require 'set'
require 'pqueue'
Input = File.readlines('./2021-15-input.txt').map { |row| row.strip.split('').map(&:to_i) }

Height = Input.length
Width = Input[0].length

Grids = 5

def cost_for(x, y)
  x1 = x % Width
  y1 = y % Height

  xgrid = x / Width
  ygrid = y / Height

  base_cost = Input[y1][x1]
  adjusted_cost = base_cost + xgrid + ygrid

  adjusted_cost > 9 ? adjusted_cost - 9 : adjusted_cost
end

def heuristic(x, y, destx = Grids*Width-1, desty = Grids*Height-1)
  # (x - destx).abs + (y - desty).abs
  # (destx - x) + (desty - y)
  0
end

# [ cost + heuristic, actual cost so far, x, y]

reached = Set.new

positions = PQueue.new([[heuristic(0, 0), 0, 0, 0]])
goal = nil
examined = 0

while ! goal
  astar, cost, x, y = *positions.shift
  examined += 1

  if x == Grids*Width-1 && y == Grids*Height-1
    goal = cost
  elsif ! reached.include?([x,y])
    reached << [x,y]

    [[x-1,y], [x+1,y], [x,y-1], [x,y+1]].each do |x1, y1|
      if x1 >= 0 && x1 < Grids*Width && y1 >= 0 && y1 < Grids*Height
        h = heuristic(x1, y1)
        newcost = cost_for(x1, y1)
        positions << [h + cost + newcost, cost + newcost, x1, y1]
      end
    end
  end
end

puts "Total cost to reach goal = #{goal}"
puts "Total search space size = #{reached.length}"
puts "Examined stated = #{examined}"