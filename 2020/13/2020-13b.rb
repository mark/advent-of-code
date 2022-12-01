f = File.readlines('./2020-13-input.txt').map(&:chomp)

arrival = f[0].to_i
buses = f[1].split(',').map.with_index { |id, idx| [id.to_i, idx] }.reject { |id, idx| id == 0 }
# buses[0][1] = 0

puts arrival
puts buses.map { |id,idx| "#{id}:#{idx}" }.join ', '

def time_until_bus(time, bus)
  since_last = time % bus

  if since_last == 0
    0
  else
    bus - since_last
  end
end

def lock_next(time, product, schedule)
  return time if schedule.empty?

  bus, idx = schedule[0]
  idx = idx % bus

  puts "Time = #{time}"
  puts "Bus = #{bus}"
  puts "Idx = #{idx}"
  puts "Product = #{ product}"

  while time_until_bus(time, bus) != idx
    puts "Wait = #{ time_until_bus(time, bus) }, hoping for #{idx}"
    time += product
    puts "Now time = #{ time }"
  end

  lock_next(time, product*bus, schedule[1..-1])
end

time = lock_next(0, 1, buses)

puts "time = #{ time }"