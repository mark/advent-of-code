class Monkey

  attr_accessor :pass, :fail, :items, :oper, :div, :inspect

  def initialize(items, oper, div)
    @items = items
    @oper = oper
    @div = div
    @inspect = 0
  end

end

Monkeys = [
  # 0
  Monkey.new([79, 98],
             ->(n) { n * 19},
             23),

  # 1
  Monkey.new([54, 65, 75, 74],
             ->(n) { n + 6 },
             19),

  # 2
  Monkey.new([79, 60, 97],
             ->(n) { n * n },
             13),

  # 3
  Monkey.new([74],
             ->(n) { n + 3 },
             17)
]

Monkeys[0].pass = Monkeys[2]
Monkeys[0].fail = Monkeys[3]

Monkeys[1].pass = Monkeys[2]
Monkeys[1].fail = Monkeys[0]

Monkeys[2].pass = Monkeys[1]
Monkeys[2].fail = Monkeys[3]

Monkeys[3].pass = Monkeys[0]
Monkeys[3].fail = Monkeys[1]

Monkeys.each_with_index do |monkey, idx|
  puts "Monkey ##{idx}: #{monkey.items.join ', ' } <#{ monkey.inspect }>"
end

Prod = Monkeys.map(&:div).inject(:*)

puts "Prod = #{ Prod }"
(1..10_000).each do |i|

  Monkeys.each_with_index do |monkey, index|
    # puts "Monkey ##{index}"
    # puts monkey.inspect
    monkey.inspect += monkey.items.length
    while monkey.items.any?
      item = monkey.items.shift
      # puts "Item was #{item}"
      item = monkey.oper[item]
      # puts "Item was #{item}"
      item = item % Prod if item >= Prod
      # puts "Item is #{item}, #{item >= Prod }"
      # puts "Item is #{item}, #{monkey.div}"

      if item % monkey.div == 0
        monkey.pass.items << item
      else
        monkey.fail.items << item
      end
    end
  end

  # puts i if i % 100 == 0

  if (i % 100 == 0)
    puts "After round #{i}"

    Monkeys.each_with_index do |monkey, idx|
      puts "Monkey ##{idx}: #{monkey.items.join ', ' } <#{ monkey.inspect }>"
    end
  end
end
