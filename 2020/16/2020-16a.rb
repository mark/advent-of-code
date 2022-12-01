input = File.readlines('./2020-16-input.txt')

read_next = :class

classes = {}
my_ticket = nil
nearby_tickets = []

input.each do |line|
  if read_next == :class
    if line =~ /(\w+): (\d+)-(\d+) or (\d+)-(\d+)/
      classes[$1] = [$2, $3, $4, $5].map(&:to_i)
    else
      read_next = :my_ticket
    end
  elsif read_next == :my_ticket
    if line =~ /^[0-9,]+$/
      my_ticket = line.split(',').map(&:to_i)
      read_next = :nearby_tickets
    end
  elsif read_next == :nearby_tickets
    if line =~ /^[0-9,]+$/
      nearby_tickets << line.split(',').map(&:to_i)
    end
  end
end

puts "classes: #{classes.inspect}"
puts "my ticket = #{my_ticket.inspect}"
puts "nearby_tickets =\n#{nearby_tickets.map(&:inspect).join "\n" }"

min_valid = classes.values.flatten.min
max_valid = classes.values.flatten.max

valid_anywhere = []
classes.each do |key, (mina, maxa, minb, maxb)|
  (mina..maxa).each { |idx| valid_anywhere[idx] = true }
  (minb..maxb).each { |idx| valid_anywhere[idx] = true }
end

puts valid_anywhere.inspect
# puts "Range = #{min_valid} - #{ max_valid }"

invalid_sum = nearby_tickets.flatten.reject { |num| valid_anywhere[num] }.sum

puts "Total invalid sum = #{ invalid_sum }"