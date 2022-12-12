start = nil
finish = nil

Elevations = File.readlines(ARGV[0]).map { |str| str.chomp.split('') }.map.with_index do |line, y|
  line.map.with_index do |char, x|
    if char == 'S'
      start = [x, y]
      0
    elsif char == 'E'
      finish = [x, y]
      25
    else
      char.ord - 'a'.ord
    end
  end
end

Height = Elevations.length
Width  = Elevations[0].length

Elevations.each do |row|
  puts row.map { |cell| cell.to_s.rjust(2) }.join(' ')
end

puts "Start = (#{start[0]}, #{start[1]}), End = (#{finish[0]}, #{finish[1]})"

Steps   = { start => 0 }
Active  = [ start ]

def visit(from, dx, dy, steps)
  x = from[0] + dx
  y = from[1] + dy
  to = [x, y]
  return unless x >= 0 && x < Width && y >= 0 && y < Height
  return unless Elevations[y][x] - Elevations[from[1]][from[0]] <= 1
  unless Steps.include?(to)
    Active << to
    Steps[to] = steps + 1
  end
end

while Active.any? && ! Steps.include?(finish)  
  current = Active.shift
  steps   = Steps[current]

  # puts "(#{current.join ', '}): <#{Active.length}>"


  visit(current,  1,  0, steps)
  visit(current, -1,  0, steps)
  visit(current,  0,  1, steps)
  visit(current,  0, -1, steps)
end

# puts Steps.inspect
puts "Steps required = #{Steps[finish]}"
