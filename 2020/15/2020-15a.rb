input = File.readlines('./2020-15-input.txt')[0]

last_spoken = Hash.new { |h, k| h[k] = [] }
last_turn = nil
turn = 0

# input.each do |line|
numbers = input.split(',').map(&:to_i)
# end

numbers.each do |num|
  turn += 1
  last_spoken[num] << turn
  last_turn = num

  puts "Turn #{ turn}: #{last_turn} (starting)"
end

while turn < 2020
  turn += 1
  last_time = last_spoken[last_turn][-1]
  prev_time = last_spoken[last_turn][-2] || last_time

  last_turn = last_time - prev_time
  last_spoken[last_turn] << turn

  puts "Turn #{ turn }: #{last_turn }"
end
