lines = File.readlines('./input.txt').map(&:chomp)

Stacks = Array.new(9) { Array.new }
InitState = []

def build_stacks
  InitState.reverse.each do |row|
    row.scan(/....?/).each_with_index do |col, i|  
      Stacks[i] << $1 if col =~ /\[(\w)\]/
    end
  end
end

def move_crate(from, to)
  Stacks[to-1] << Stacks[from-1].pop
end

def print_stacks
  Stacks.each_with_index do |stack, i|
    puts "#{i+1}: #{stack.join ' ' }"
  end
end

lines.each do |line|
  if line =~ /^(\s|\d)+$/
    build_stacks
  elsif line =~ /move (\d+) from (\d) to (\d)/
    $1.to_i.times { move_crate($2.to_i, $3.to_i) }
  else
    InitState << line
  end
end

print_stacks

puts Stacks.map { |stack| stack[-1] }.join