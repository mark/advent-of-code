input = File.readlines('./2020-14-input.txt')

Char2Mask = { 'X' => nil, '0' => 0, '1' => 1 }

mask = []
memory = {}

def apply_mask(value, mask)
  bits = value.to_s(2).rjust(mask.length, '0').split('')

  masked_bits = bits.zip(mask).map { |b, m| m || b }

  masked_bits.join('').to_i(2)
end

input.each do |line|
  if line =~ /mask = ([X01]+)/
    mask = $1.split('').map { |c| Char2Mask[c] }
  elsif line =~ /mem\[(\d+)\] = (\d+)/
    addr = $1.to_i
    value = $2.to_i

    memory[addr] = apply_mask(value, mask)
    puts "value = #{value} becomes #{ apply_mask(value, mask) }"
  else
    puts "ERROR: #{line}"
  end
end

puts memory.values.compact.sum
