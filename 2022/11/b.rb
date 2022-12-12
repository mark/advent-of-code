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
  Monkey.new([72, 64, 51, 57, 93, 97, 68],
             ->(n) { n * 19 },
             17),

  # 1
  Monkey.new([62], ->(n) { n * 11 }, 3),

  # 2
  Monkey.new([57, 94, 69, 79, 72],
             ->(n) { n + 6 },
             19),

  #3
  Monkey.new([80, 64, 92, 93, 64, 56],
             ->(n) { n + 5 },
             7),

  # 4
  Monkey.new([70, 88, 95, 99, 78, 72, 65, 94],
             ->(n) { n + 7 },
             2),

  # 5
  Monkey.new([57, 95, 81, 61],
             ->(n) { n * n },
             5),

  # 6
  Monkey.new([79, 99],
             ->(n) { n + 2 },
             11),

  # 7
  Monkey.new([68, 98, 62],
             ->(n) { n + 3 },
             13)
]

Monkeys[0].pass = Monkeys[4]
Monkeys[0].fail = Monkeys[7]

Monkeys[1].pass = Monkeys[3]
Monkeys[1].fail = Monkeys[2]

Monkeys[2].pass = Monkeys[0]
Monkeys[2].fail = Monkeys[4]

Monkeys[3].pass = Monkeys[2]
Monkeys[3].fail = Monkeys[0]

Monkeys[4].pass = Monkeys[7]
Monkeys[4].fail = Monkeys[5]

Monkeys[5].pass = Monkeys[1]
Monkeys[5].fail = Monkeys[6]

Monkeys[6].pass = Monkeys[3]
Monkeys[6].fail = Monkeys[1]

Monkeys[7].pass = Monkeys[5]
Monkeys[7].fail = Monkeys[6]

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

top_2 = Monkeys.map(&:inspect).sort.reverse.take(2).inject(:*)

puts "Product of top 2 = #{top_2}"