mods = File.readlines('./2019-01-input.txt')

total = mods.map { |line| line.to_i / 3 - 2 }.sum

puts "Total = #{total}"

