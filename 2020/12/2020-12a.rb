f = File.readlines('./2020-12-input.txt')

Angles = {
    0 => { dx:  1, dy:  0 },
   90 => { dx:  0, dy:  1 },
  180 => { dx: -1, dy:  0 },
  270 => { dx:  0, dy: -1 }
}

Absolutes = {
  'E' => { dx:  1, dy:  0 },
  'N' => { dx:  0, dy:  1 },
  'W' => { dx: -1, dy:  0 },
  'S' => { dx:  0, dy: -1 }
}

east = 0
north = 0
angle = 0

f.each do |instr|
  if instr =~ /F(\d+)/
    east += Angles[angle][:dx] * $1.to_i
    north += Angles[angle][:dy] * $1.to_i
  elsif instr =~ /L(\d+)/
    angle = (angle + $1.to_i) % 360
  elsif instr =~ /R(\d+)/
    angle = (angle - $1.to_i + 360) % 360
  elsif instr =~ /([NEWS])(\d+)/
    east += Absolutes[$1][:dx] * $2.to_i
    north += Absolutes[$1][:dy] * $2.to_i
  else
    raise "I don't understand #{instr}"
  end
end

puts "Final location = #{east} east, #{north} north"
puts "Solution = #{east.abs + north.abs}"