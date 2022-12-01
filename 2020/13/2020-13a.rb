f = File.readlines('./2020-13-input.txt').map(&:chomp)

arrival = f[0].to_i
buses = f[1].split(',').map(&:to_i).reject { |t| t == 0 }

puts arrival
puts buses.join ', '

def time_until_bus(time, bus)
  since_last = time % bus

  if since_last == 0
    0
  else
    bus - since_last
  end
end

next_bus = buses.min_by { |bus| time_until_bus(arrival, bus) }

wait_time = time_until_bus(arrival, next_bus)

puts "Next bus = #{ next_bus }, wait = #{ wait_time }, code = #{ next_bus * wait_time }"