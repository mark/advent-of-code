class Intcode

  attr_accessor :memory

  def initialize(memory)
    @memory = memory.dup
  end

  def execute
    pc = 0
    running = true

    while running do
      opcode = memory[pc]

      addr1 = memory[pc+1]
      addr2 = memory[pc+2]
      addr3 = memory[pc+3]

      case opcode
      when 1
        memory[addr3] = memory[addr1] + memory[addr2]
        pc += 4
      when 2
        memory[addr3] = memory[addr1] * memory[addr2]
        pc += 4
      when 99
        running = false
      end
    end

    return memory[0]
  end

end