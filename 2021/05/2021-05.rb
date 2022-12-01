f = File.readlines('./2021-05-input.txt')

vents = f.map do |line|
  if line =~ /(\d+),(\d+) -> (\d+),(\d+)/
    [$1,$2,$3,$4].map(&:to_i)
  else
    puts "ERRROR #{line}"
  end
end

def sgn(n)
  n > 0 ? 1 : (n < 0 ? -1 : 0)
end

min_x = vents.flat_map { |x1,y1,x2,y2| [x1, x2] }.min
max_x = vents.flat_map { |x1,y1,x2,y2| [x1, x2] }.max
min_y = vents.flat_map { |x1,y1,x2,y2| [y1, y2] }.min
max_y = vents.flat_map { |x1,y1,x2,y2| [y1, y2] }.max

# puts vents.inspect
straight_vents = vents# .select { |x1,y1,x2,y2| (x1 == x2) || (y1 == y2) }

counts = Hash.new { |h,k| h[k] = 0 }

# puts straight_vents.inspect
straight_vents.each do |x1,y1,x2,y2|
  dx = x2 - x1
  dy = y2 - y1
  steps = [dx.abs, dy.abs].max
  dx = sgn(dx)
  dy = sgn(dy)

  # puts "!!! #{[x1, y1, x2, y2]}" if dx.abs != dy.abs && dx != 0 && dy != 0
  (steps+1).times do |i|
    counts[[x1 + dx*i, y1 + dy*i]] += 1
  end

  # puts "From (#{minx},#{miny}) -> (#{maxx},#{maxy})"
  # (minx..maxx).each do |x|
  #   (miny..maxy).each do |y|
  #     counts[[x,y]] += 1
  #   end
  # end
end

(min_y..max_y).each do |y|
  (min_x..max_x).each do |x|
    num = counts[[x,y]]
    print num == 0 ? '.' : num
  end
  puts
end

puts "Dangerous count = #{ counts.values.count { |v| v >= 2 }}"
# counts.each_pair do |(x,y),value|
#   puts "(#{x},#{y}) => #{value}"
# end
