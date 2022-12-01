input = File.readlines('./2020-13-input.txt').map(&:chomp)
buses = input[1].split(',').map.with_index { |id, idx| [id.to_i, idx] }.reject { |id, idx| id == 0 }

print("time = ", buses.inject([0, 1]) do |(time, product), (bus, idx)|
  time += product while (time % bus == 0 ? 0 : bus - (time % bus)) != (idx % bus)
  [time, product * bus]
end[0], "\n")