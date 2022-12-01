require 'pp'
lines = File.readlines("./2020-08-input.txt")

program = lines.map do |line|
  if line =~ /(\w+)\s([-+]\d+)/
    [$1, $2.to_i]
  else
    raise "Invalid line #{ line }"
  end
end

# pp program

def execute(prog, twiddle = -1)
  acc  = 0
  pc   = 0
  exed = []

  loop do
    return [:loop, acc] if exed[pc]
    return [:term, acc] if pc == prog.length
    return [:err, acc]  if pc > prog.length

    exed[pc] = true
    instr, arg = *prog[pc]

    case instr
      when 'nop' then pc  += (pc == twiddle) ? arg : 1
      when 'jmp' then pc  += (pc == twiddle) ? 1 : arg
      when 'acc' then acc += arg; pc += 1
    end
  end
end

program.length.times do |twiddle|
  int, acc = *execute(program, twiddle)
  puts "Twiddle = #{ twiddle}\tInterrupt = #{int}\tAccumulator = #{ acc }"
end
