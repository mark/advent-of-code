lines = File.readlines('./input.txt').map { |l| l.split(',').map(&:chomp) }

require 'set'

def follow_path(path)
  set = Set.new
  timings = Hash.new

  x, y, t = 0, 0, 0

  path.each do |instr|
    if instr =~ /R(\d+)/
      # puts "Right #{$1.to_i}"
      $1.to_i.times do
        x += 1
        t += 1
        set << [x, y]
        timings[[x, y]] ||= t
      end
    elsif instr =~ /L(\d+)/
      # puts "Left #{$1.to_i}"
      $1.to_i.times do
        x -= 1
        t += 1
        set << [x, y]
        timings[[x, y]] ||= t
      end
    elsif instr =~ /U(\d+)/
      # puts "Up #{$1.to_i}"
      $1.to_i.times do
        y += 1
        t += 1
        set << [x, y]
        timings[[x, y]] ||= t
      end
    elsif instr =~ /D(\d+)/
      # puts "Down #{$1.to_i}"
      $1.to_i.times do
        y -= 1
        t += 1
        set << [x, y]
        timings[[x, y]] ||= t
      end
    else
      puts "I don't understand #{instr.inspect}"
    end
  end

  # puts set.inspect
  return set, timings
end

set0, time0 = follow_path(lines[0])
set1, time1 = follow_path(lines[1])

crossings = set0 & set1

closest = crossings.min_by { |xy| time0[xy] + time1[xy] }

puts "Quickest = (#{closest[0]}, #{closest[1]})"
puts time0[closest] + time1[closest]
# puts (set0 & set1).inspect