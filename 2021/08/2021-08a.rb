input = File.readlines('./2021-08-input.txt')

counts = input.map do |line|
  output = line.split(' | ')[1].split(' ')
  puts output.inspect

  output.count { |segments| [2, 3, 4, 7].include? segments.length }
end.sum

puts "Found #{ counts } instances of 1, 4, 7, or 8"
