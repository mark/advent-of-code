file = ARGV[0] || 'input'
input = File.readlines("./2021-17-#{file}.txt")[0]

input =~ /x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/

minx, maxx, miny, maxy = *[$1, $2, $3, $4].map(&:to_i)

puts "Bounds = (#{minx}, #{miny}) - (#{maxx}, #{maxy})"

def solve_y(ymin, ymax)
  total_max = 0
  (0..20_000).each do |vel|
    vel0 = vel
    pos = 0
    max = 0
    target_reached = false

    while pos > ymin
      pos += vel
      vel -= 1
      max = pos if max < pos

      target_reached ||= ymin <= pos && pos <= ymax
    end

    puts "Velocity = #{ vel0 }, yMax = #{max}" if target_reached
    total_max = max if total_max < max && target_reached
  end

  puts "Highest yMax found = #{ total_max}"
end

solve_y(miny, maxy)