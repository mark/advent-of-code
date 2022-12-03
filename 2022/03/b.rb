require '../../helpers'

lines = File.readlines('./input.txt').map(&:chomp)

Priorities = ['-'] + ('a'..'z').to_a + ('A'..'Z').to_a

total = lines.in_groups_of(3).map do |lines|
  splits = lines.map { |line| line.split('') }

  common = (splits[0] & splits[1] & splits[2])[0]

  Priorities.index common
end.sum

puts "Total priority = #{ total }"
