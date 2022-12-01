file = ARGV[0] || 'input'
input = File.readlines("./2021-17-#{file}.txt")[0]

input =~ /x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/

minx, maxx, miny, maxy = *[$1, $2, $3, $4].map(&:to_i)

puts "Bounds = (#{minx}, #{miny}) - (#{maxx}, #{maxy})"

def solve_x(xmin, xmax, maxwait)
  successes = {}

  (1..1000).each do |vel|
    vel0 = vel
    pos = 0
    max = 0
    t = 0
    valid_times = []

    while t <= maxwait && pos <= xmax
      pos += vel
      vel -= 1 if vel > 0
      t += 1

      valid_times << t if xmin <= pos && pos <= xmax
    end

    successes[vel0] = valid_times if valid_times.any?
  end

  successes
end

def solve_y(ymin, ymax)
  successes = {}

  (-500..500).each do |vel|
    vel0 = vel
    pos = 0
    valid_times = []
    t = 0

    while pos >= ymin
      t += 1
      pos += vel
      vel -= 1

      valid_times << t if ymin <= pos && pos <= ymax
    end

    successes[vel0] = valid_times if valid_times.any?
  end

  successes
end

puts "Y:"
valid_ys = solve_y(miny, maxy)

maxwait = valid_ys.values.flatten.max

puts "Maxwait = #{maxwait}"
puts "X:"
valid_xs = solve_x(minx, maxx, maxwait)

puts "Found #{valid_xs.length} Xs, #{valid_ys.length} Ys"

valid_xy = []

valid_xs.each do |velx, xtimes|
  valid_ys.each do |vely, ytimes|
    valid_xy << [velx, vely] if (xtimes & ytimes).any?
  end
end

valid_xy.each do |x, y|
  puts "(#{x}, #{y})"
end

puts "Found #{valid_xy.length} valid pairs"