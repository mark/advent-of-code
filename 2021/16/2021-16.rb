require 'pp'
input = File.readlines('./2021-16-input.txt')

class BitReader

  Operators = [:sum, :prod, :min, :max, nil, :gt, :lt, :eq]

  def self.[](hex)
    bits = hex.to_i(16).to_s(2).rjust(4*hex.length, '0').split('').map(&:to_i)
    new(bits)
  end

  def initialize(bits)
    @bits = bits
    puts @bits.join
    @head = 0
  end

  def read_bit
    bit = @bits[@head]
    @head += 1
    bit
  end

  def read_int_fixed(length)
    int = 0
    length.times { int = int << 1 | read_bit }
    int
  end

  def read_int_dynamic
    int = 0
    next_group = 1

    while next_group > 0
      next_group = read_bit
      int = int << 4 | read_int_fixed(4)
    end

    int
  end

  def read_packets_count(count)
    (0...count).map { read_packet }
  end

  def read_packets_fixed(length)
    start = @head
    [].tap do |packets|
      packets << read_packet while (@head - start) < length
    end
  end

  def read_packets_dynamic
    if read_bit == 0
      read_packets_fixed read_int_fixed(15)
    else
      read_packets_count read_int_fixed(11)
    end
  end

  def read_packet
    header = { version: read_int_fixed(3) }

    if operator = Operators[ read_int_fixed(3) ]
      header.merge(operator: operator, packets: read_packets_dynamic)
    else
      header.merge(literal: read_int_dynamic)
    end
  end

end

class Walker
  def initialize(packet)
    @root = packet
  end

  def evaluate(packet = @root)
    if packet[:literal]
      evaluate_leaf(packet)
    else
      evaluate_branch(packet, packet[:packets].map { |sub| evaluate(sub) })
    end
  end
end

class VersionSum < Walker
  def evaluate_leaf(packet)
    packet[:version]
  end

  def evaluate_branch(packet, subvalues)
    packet[:version] + subvalues.sum
  end
end

class Executor < Walker
  def evaluate_leaf(packet)
    packet[:literal]
  end

  def evaluate_branch(packet, subvalues)
    case packet[:operator]
    when :sum  then subvalues.sum
    when :prod then subvalues.inject(1) { |prod, val| prod * val }
    when :min  then subvalues.min
    when :max  then subvalues.max
    when :gt   then subvalues[0] >  subvalues[1] ? 1 : 0
    when :lt   then subvalues[0] <  subvalues[1] ? 1 : 0
    when :eq   then subvalues[0] == subvalues[1] ? 1 : 0
    end
  end
end

input.each do |hex|
  reader = BitReader[hex]
  packet = reader.read_packet
  puts "Hex = #{hex}"
  pp packet
  value = Executor.new(packet).evaluate
  puts "Result = #{value}"
  puts "Version sum = #{ VersionSum.new(packet).evaluate }"
  puts; puts
end