require './helpers'

f = File.readlines('./2021-01-input.txt').map(&:to_i)

# windows = f[0..-3].zip(f[1..-1], f[2..-1]).map(&:sum)
# last = windows[0]
# count = 0

# windows.each do |depth|
#   count += 1 if depth > last
#   last = depth
# end

# count = windows[0...-1].zip(windows[1..-1]).count { |a,b| a < b }

count = f.window(3).map { |*items| items.sum }.window(2).count { |a,b| a < b }

puts count # 1728