require './helpers'

f = File.readlines('./2021-01-input.txt').map(&:to_i)

count = f.window(2).count { |a,b| a < b }

# count = f[0...-1].zip(f[1..-1]).count { |a,b| a < b }


# last = f[0]
# count = 0

# f.each do |depth|
#   count += 1 if depth > last
#   last = depth
# end

puts count # 1688