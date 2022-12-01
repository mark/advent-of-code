f = File.readlines('./2020-12-input.txt')

Cosine = {
    0 => { dx:  1, dy:  0 },
   90 => { dx:  0, dy:  1 },
  180 => { dx: -1, dy:  0 },
  270 => { dx:  0, dy: -1 }
}

Sine = {
    0 => { dy:  1, dx:  0 },
   90 => { dy:  0, dx:  1 },
  180 => { dy: -1, dx:  0 },
  270 => { dy:  0, dx: -1 }
}

Absolutes = {
  'E' => { dx:  1, dy:  0 },
  'N' => { dx:  0, dy:  1 },
  'W' => { dx: -1, dy:  0 },
  'S' => { dx:  0, dy: -1 }
}

def rotate(x, y, degrees)
  turns = degrees / 90
  turns.times do
    x, y = -y, x
  end
  return x, y
  # x1 = x * Cosine[degrees][:dx] + y * Cosine[degrees][:dy]
  # y1 = x * Sine[degrees][:dx] + y * Sine[degrees][:dy]

  # return x1, y1
end

east = 0
north = 0
way_east = 10
way_north = 1

f.each do |instr|
  if instr =~ /F(\d+)/
    east  += way_east * $1.to_i
    north += way_north * $1.to_i
  elsif instr =~ /L(\d+)/
    way_east, way_north = rotate(way_east, way_north, $1.to_i)
  elsif instr =~ /R(\d+)/
    way_east, way_north = rotate(way_east, way_north, (360-$1.to_i) % 360)
  elsif instr =~ /([NEWS])(\d+)/
    way_east += Absolutes[$1][:dx] * $2.to_i
    way_north += Absolutes[$1][:dy] * $2.to_i
  else
    raise "I don't understand #{instr}"
  end

  puts instr
  puts "location = #{east} east, #{north} north"
  puts "waypoint = #{way_east} east, #{way_north} north"
  puts
end

puts "Final location = #{east} east, #{north} north"
puts "Solution = #{east.abs + north.abs}"