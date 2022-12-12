require '../../helpers'

SearchLength = 14

signal = File.read('./input.txt').chomp

signal.split('').window(SearchLength).each.with_index do |wind, idx|
  puts "chars processed = #{idx+SearchLength}" if wind.uniq.length == SearchLength
end
