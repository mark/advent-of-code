lines = File.readlines('./input.txt').map { |l| l.split(',').map(&:chomp) }

require 'set'

def follow_path(path)
  set = Set.new

  x, y = 0, 0

  path.each do |instr|
    if instr =~ /R(\d+)/
      # puts "Right #{$1.to_i}"
      $1.to_i.times do
        x += 1
        set << [x, y]
      end
    elsif instr =~ /L(\d+)/
      # puts "Left #{$1.to_i}"
      $1.to_i.times do
        x -= 1
        set << [x, y]
      end
    elsif instr =~ /U(\d+)/
      # puts "Up #{$1.to_i}"
      $1.to_i.times do
        y += 1
        set << [x, y]
      end
    elsif instr =~ /D(\d+)/
      # puts "Down #{$1.to_i}"
      $1.to_i.times do
        y -= 1
        set << [x, y]
      end
    else
      puts "I don't understand #{instr.inspect}"
    end
  end

  # puts set.inspect
  return set
end

set0 = follow_path(lines[0])
set1 = follow_path(lines[1])

crossings = set0 & set1

closest = crossings.min_by { |(x, y)| x.abs + y.abs }

puts "Closest = (#{closest[0]}, #{closest[1]})"
puts closest[0].abs + closest[1].abs
# puts (set0 & set1).inspect