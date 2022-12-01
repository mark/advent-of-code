f = File.readlines('./2021-03-input.txt').map(&:chomp).map { |s| s.split('') }

total_lines = f.length
bit_length = f[0].length
set_bits = [0] * f[0].length

f.each { |s| s.each_with_index { |bit, idx| set_bits[idx] += 1 if bit == '1' }}

gamma_bits = (0...bit_length).map { |idx| set_bits[idx] > (total_lines-set_bits[idx]) ? 1 : 0 }
epsilon_bits = gamma_bits.map { |b| 1 - b }

gamma = gamma_bits.join('').to_i(2)
epsilon = epsilon_bits.join('').to_i(2)

puts "Gamma = #{ gamma }, epsilon = #{epsilon}, product = #{ gamma * epsilon }"
