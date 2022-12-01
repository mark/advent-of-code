input = File.readlines('./2020-14-input.txt')

mask = []
memory = {}

def build_value(initial, value, mask, idx)
  return [initial] if idx >= mask.length
  case mask[idx]
  when '0' then build_value(initial + value[idx], value, mask, idx+1)
  when '1' then build_value(initial + '1', value, mask, idx+1)
  when 'X' then build_value(initial + '0', value, mask, idx+1) + build_value(initial + '1', value, mask, idx+1)
  end
end

def apply_mask(value, mask)
  bits = value.to_s(2).rjust(mask.length, '0').split('')

  # puts "  #{bits.join '' }"
  # puts "  #{mask.join '' }"
  masked_bits = build_value('', bits, mask, 0)

  masked_bits.map { |s| s.to_i(2) }
end

input.each do |line|
  if line =~ /mask = ([X01]+)/
    mask = $1.split('')
  elsif line =~ /mem\[(\d+)\] = (\d+)/
    addr = $1.to_i
    value = $2.to_i

    masked_addrs = apply_mask(addr, mask)
    # puts "addr = #{value} becomes:\n  #{ masked_addrs.join(", ") }"
    masked_addrs.each { |addr| memory[addr] = value }
  else
    puts "ERROR: #{line}"
  end
end

puts memory.values.compact.sum
