require 'set'
input = File.readlines('./2016-11-input.txt')

Elements = Hash.new { |h, k| h[k] = h.length }

positions = input.flat_map.with_index do |line, floorno|
  line =~ /The \w+ floor contains (.+)[.]$/
  $1.split(/, and|,|and/).map(&:strip).map do |component|
    if component =~ /a (\w+)-compatible microchip/
      [:microchip, $1, Elements[$1], floorno, 2 * Elements[$1] + 3]
    elsif component =~ /a (\w+) generator/
      [:generator, $1, Elements[$1], floorno, 2 * Elements[$1] + 2]
    else
      nil
    end
  end
end.compact

positions += [
  [:microchip, 'elerium', Elements['elerium'], 0, 2 * Elements['elerium'] + 3],
  [:generator, 'elerium', Elements['elerium'], 0, 2 * Elements['elerium'] + 2],
  [:microchip, 'dilithium', Elements['dilithium'], 0, 2 * Elements['dilithium'] + 3],
  [:generator, 'dilithium', Elements['dilithium'], 0, 2 * Elements['dilithium'] + 2]
] if false # For part 2 only

puts positions.inspect

starting_position = Array.new(2 + 2 * Elements.length) { 0 }
positions.each { |item, element, element_id, floorno, item_code| starting_position[item_code] = floorno }

puts starting_position.inspect

# [ total steps, elevator, element0-microchip, element0-generator, element1-microchip, element1-generator, ...]

def goal?(position)
  position[2..-1].all? { |floor| floor == 3 }
end

def floor_for_generator(position, e_id)
  position[2 * e_id + 2]
end

def floor_for_microchip(position, e_id)
  position[2 * e_id + 3]
end

def safe?(position)
  # A position is safe if every microchip is safe
  # A microchip is safe if one of:
  #   - it is shielded (on the same floor as its generator)
  #   - there are no other generators on the same floor

  (0...Elements.length).all? do |e_id| # Each microchip
    m_floor = floor_for_microchip(position, e_id)

    # puts "checking chip #{ e_id } is on #{ m_floor }"
    shielded = (floor_for_generator(position, e_id) == m_floor)
    no_radiation = (0...Elements.length).all? { |g_id| (e_id == g_id) || floor_for_generator(position, g_id) != m_floor }

    shielded || no_radiation
  end
end

def items_on_floor(position, floorno)
  (2..position.length).select { |item| position[item] == floorno }
end

seen_positions   = Set.new

active_positions = [starting_position]
final_position   = nil

counter = 0
while active_positions.any? && ! final_position
  position = active_positions.shift
  # puts "Consider #{ position.join ',' } (#{seen_positions.length})"

  if seen_positions.include?(position[1..-1].join ',')
    # stop here
  elsif ! safe?(position)
    # stop here
  elsif goal?(position)
    final_position = position
  else
    steps    = position[0]
    elevator = position[1]
    items = items_on_floor(position, elevator)
    item_sets = items.combination(1).to_a + items.combination(2).to_a

    # puts "Position = #{position.join ' '}: items on floor = #{items.join ', '}"
    item_sets.each do |items|
      # puts "Planning to move #{items.join ' & '}"
      if elevator > 0 # Can go down
        new_position = position.dup
        new_floor = elevator - 1 # Down 1 floor
        new_position[0] += 1 # Take a step
        new_position[1] = new_floor
        items.each { |item| new_position[item] = new_floor }

        active_positions << new_position
        # puts "#{position.join ','} ==> #{new_position.join ','}"
      end

      if elevator < 3 # Can go up
        new_position = position.dup
        new_floor = elevator + 1 # Up 1 floor
        new_position[0] += 1 # Take a step
        new_position[1] = new_floor
        items.each { |item| new_position[item] = new_floor }

        active_positions << new_position
        # puts "#{position.join ','} ==> #{new_position.join ','}"
      end
    end

    puts "#{counter}: #{position.join ' '} : #{ seen_positions.length }" if counter % 1_000 == 0
    counter += 1
  end

  seen_positions << position[1..-1].join(',')
end


puts final_position.inspect
puts seen_positions.length