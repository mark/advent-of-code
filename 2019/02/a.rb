require '../intcode'

memory = File.read('./input.txt').split(/,/).map(&:to_i)

memory[1] = 12
memory[2] = 2

compy = Intcode.new(memory)

output = compy.execute

puts output


