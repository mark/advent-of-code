input = File.readlines('./2020-15-input.txt')[0]

last_spoken = Hash.new
prev_spoken = Hash.new
last_turn = nil
turn = 0

numbers = input.split(',').map(&:to_i)

numbers.each do |num|
  turn += 1
  last_turn = num
  last_spoken[last_turn], prev_spoken[last_turn] = turn, last_spoken[last_turn]

  puts "Turn #{ turn}: #{last_turn } (starting)"
end

while turn < 30_000_000
  turn += 1

  puts turn if turn % 100_000 == 0
  last_time = last_spoken[last_turn]
  prev_time = prev_spoken[last_turn] || last_time

  # puts "last turn = #{ last_turn }"
  # puts last_spoken.inspect
  # puts prev_spoken.inspect

  last_turn = last_time - prev_time
  last_spoken[last_turn], prev_spoken[last_turn] = turn, last_spoken[last_turn]

  # puts "Turn #{ turn }: #{last_turn }"
end

puts "Turn #{ turn }: #{last_turn }"
