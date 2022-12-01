require 'set'
input = File.readlines('./2020-17-input.txt').map(&:chomp)

def neighbors(x, y, z, w)
  [x-1, x, x+1].each do |x1|
    [y-1, y, y+1].each do |y1|
      [z-1, z, z+1].each do |z1|
        [w-1, w, w+1].each do |w1|
          yield(x1, y1, z1, w1) if x != x1 || y != y1 || z != z1 || w != w1
        end
      end
    end
  end
end

current = Set.new
input.each_with_index do |row, y|
  row.split('').each_with_index do |cell, x|
    current << [x,y,0,0] if cell == '#'
  end
end

Height0 = input.length
Width0 = input[0].length

i = 0
(-i..i).each do |z|
  puts "z=#{z}"
  (-i..(Height0+i-1)).each do |y|
    (-i..(Width0+i-1)).each do |x|
      print current.include?([x,y,z]) ? '#' : '.'
    end
    puts
  end
  puts
end

puts "At start, alive count = #{ current.length}"
(1..6).each do |i|
  next_state = Set.new

  (-i..(Width0+i)).each do |x|
    (-i..(Height0+i)).each do |y|
      (-i..i).each do |z|
        (-i..i).each do |w|
          count = 0
          alive = current.include?([x,y,z,w])

          neighbors(x, y, z, w) do |x1, y1, z1, w1|
            count += 1 if current.include?([x1,y1,z1,w1])
          end

          # puts "Now checking (#{x},#{y},#{z}), alive = #{ alive }, neighbor count = #{ count }" if z == 0

          if alive && (count == 2 || count == 3)
            next_state << [x,y,z,w]
          elsif !alive && count == 3
            next_state << [x,y,z,w]
          end
        end
      end
    end
  end

  current = next_state
  puts "At time = #{i}: alive count = #{ current.length}"

  # (-i..i).each do |z|
  #   puts "z=#{z}"
  #   (1-i..(Height0+i-1)).each do |y|
  #     (1-i..(Width0+i-1)).each do |x|
  #       print current.include?([x,y,z]) ? '#' : '.'
  #     end
  #     puts
  #   end
  #   puts
  # end
end