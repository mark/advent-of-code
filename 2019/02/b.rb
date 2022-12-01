require '../intcode'

memory = File.read('./input.txt').split(/,/).map(&:to_i)

100.times do |mem1|
  100.times do |mem2|
    memory[1] = mem1
    memory[2] = mem2

    compy = Intcode.new(memory)

    output = compy.execute

    if output == 19690720
      puts "(#{mem1}, #{mem2}) => #{output}"
      puts "#{100 * mem1 + mem2}"
    end
  end
end
