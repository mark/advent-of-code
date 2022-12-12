program = File.readlines(ARGV[0]).map(&:chomp)

SignalStr = [1]

cycle = 1
register = 1

program.each do |instr|
  if instr =~ /addx (-?\d+)/
    SignalStr << register << register
    cycle += 2
    register += $1.to_i
  elsif instr == "noop"
    SignalStr[cycle] = register
    cycle += 1
  else
    puts "I don't understand #{line.inspect}"
  end
end

# SignalStr.each_with_index do |str, cycle|
#   puts "#{cycle.to_s.rjust(3)}: #{str}"
# end

# (1..40).each do |idx|
#   print idx.to_s.rjust(3)
#   print ' '
# end

# puts; puts

(1..240).each do |cycle|
  sprite = SignalStr[cycle]
  beam   = (cycle-1) % 40

  print (sprite - beam).abs < 2 ? '#' : ' '
  # print reg.to_s.rjust(3)
  # print ' '
  puts if cycle % 40 == 0
end