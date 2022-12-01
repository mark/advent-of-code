require 'set'
input = File.readlines('./2020-16-input.txt')

read_next = :class

classes = {}
my_ticket = nil
nearby_tickets = []

input.each do |line|
  if read_next == :class
    if line =~ /([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/
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

# puts "classes: #{classes.inspect}"
# puts "my ticket = #{my_ticket.inspect}"
# puts "nearby_tickets =\n#{nearby_tickets.map(&:inspect).join "\n" }"

min_valid = classes.values.flatten.min
max_valid = classes.values.flatten.max

valid_anywhere = Array.new(max_valid+1) { Set.new }

classes.each do |key, (mina, maxa, minb, maxb)|
  (mina..maxa).each { |idx| valid_anywhere[idx] << key }
  (minb..maxb).each { |idx| valid_anywhere[idx] << key }
end

# puts valid_anywhere.inspect
# puts "Range = #{min_valid} - #{ max_valid }"

valid_tickets = nearby_tickets.select { | ticket| ticket.all? { |value| valid_anywhere[value] && valid_anywhere[value].any? }}
# invalid_tickets = nearby_tickets.reject { | ticket| ticket.all? { |value| valid_anywhere[value] && valid_anywhere[value].any? }}

# invalid_values = invalid_tickets.flatten.reject { |value| valid_anywhere[value] && valid_anywhere[value].any? }

# puts "Total invalid sum = #{ invalid_values.sum }"

possible_orders = Array.new(my_ticket.length) { Set.new(classes.keys) }

# puts possible_orders.inspect

def resolve(possibles, order)
  value = possibles[order]
  to_resolve = []
  possibles.each_with_index do |keys, keyorder|
    if order != keyorder
      has_value = (keys & value).any?
      possibles[keyorder] = keys - value

      if has_value && possibles[keyorder].length == 1
        to_resolve << keyorder
      end
    end
  end

  to_resolve.each { |idx| resolve(possibles, idx) }
end

valid_tickets.each do |ticket|
  ticket.each_with_index do |value, order|
    possible_orders[order] &= valid_anywhere[value]

    if possible_orders[order].length == 1
      resolve(possible_orders, order)
    end
  end
end

right_order = possible_orders.map { |set| set.first }

puts right_order.inspect

solution = my_ticket.zip(right_order).flat_map { |value, key| key =~ /departure/ ? value : 1 }

puts "Solution = #{ solution.inject(1) { |prod, val| prod * val } }"