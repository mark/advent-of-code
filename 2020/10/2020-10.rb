adapters = File.readlines("./2020-10-input.txt").map(&:to_i).sort

wall               = adapters.max+3
adapters_with_0    = [0] + adapters
adapters_with_wall = adapters + [wall]

counts = Hash.new { |h, k| h[k] = 0 }
adapters_with_0.zip(adapters_with_wall).each do |low, hi|
  # puts "#{low} -> #{ hi }"
  counts[hi-low] += 1
end

puts counts.inspect
puts counts[1] * counts[3]

ways = Hash.new { |h, k| h[k] = 0 }
ways[0] = 1

adapters_with_wall.each do |ad|
  ways[ad] = ways[ad-1] + ways[ad-2] + ways[ad-3]
end

puts "Wall = #{ wall }, ways = #{ ways[wall] }"