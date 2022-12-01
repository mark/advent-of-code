f = File.readlines('./2021-02-input.txt')

distance = 0
depth = 0
aim = 0

f.each do |line|
  if line =~ /forward (\d+)/
    distance += $1.to_i
    depth += aim * $1.to_i
  elsif line =~ /up (\d+)/
    aim -= $1.to_i
  elsif line =~ /down (\d+)/
    aim += $1.to_i
  else
    raise "I don't understand: #{line}"
  end
end

puts "Distance = #{distance}, depth = #{depth}, result = #{distance*depth}"