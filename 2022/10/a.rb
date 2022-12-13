program = File.readlines(ARGV[0]).map(&:chomp)

SignalStr = [1]

cycle = 1
register = 1

program.each do |instr|
  if instr =~ /addx (-?\d+)/
    value = $1.to_i
    SignalStr << register << register
    cycle += 2
    register += value
  elsif instr == "noop"
    SignalStr[cycle] = register
    cycle += 1
  else
    puts "I don't understand #{line.inspect}"
  end
end

SignalStr.each_with_index do |str, cycle|
  puts "#{cycle.to_s.rjust(3)}: #{str}"
end

CheckCycles = [20, 60, 100, 140, 180, 220]

CheckCycles.each do |cycle|
  # value = SignalStr[cycle-1]
  value = SignalStr[cycle]
  puts "During the #{cycle}th cycle, register X has the value #{value}, so the signal strength is #{cycle} * #{value} = #{cycle*value}."
end

# sum = CheckCycles.map { |cycle| cycle * SignalStr[cycle-1] }.sum
sum = CheckCycles.map { |cycle| cycle * SignalStr[cycle] }.sum

puts "Sum value = #{ sum }"