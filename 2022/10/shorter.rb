program = File.readlines(ARGV[0]).map(&:chomp)

SignalStr = [1]

cycle = 1
register = 1

program.each do |instr|
  if instr =~ /addx (-?\d+)/
    SignalStr << register << register
    cycle += 2
    register += $1.to_i
  else
    SignalStr[cycle] = register
    cycle += 1
  end
end

(1..240).each do |cycle|
  sprite = SignalStr[cycle]
  beam   = (cycle-1) % 40

  print (sprite - beam).abs < 2 ? '⬛' : '⬜'
  puts if cycle % 40 == 0
end