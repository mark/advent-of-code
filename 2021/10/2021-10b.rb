input = File.readlines('./2021-10-input.txt').map(&:chomp)

Score = {
  "(" => 1,
  "[" => 2,
  "{" => 3,
  "<" => 4
}

IsOpen = ["(", "[", "{", "<"]
Matching = {")" => "(", "]" => "[", "}" => "{", ">" => "<"}

def score_stack(stack)
  puts stack.reverse.join('')
  stack.reverse.inject(0) { |score, char| 5 * score + Score[char] }
end


def score_line(chars)
  stack = []

  chars.each do |char|
    if IsOpen.include?(char)
      stack << char
    elsif Matching[char] == stack[-1]
      stack.pop
    else
      # puts "Char = #{ char}, Expected #{Matching[char]}, found #{stack[-1]}"
      return nil
    end
  end

  score_stack(stack)
end

score = input.map do |line|
  chars = line.split('')

  score_line(chars)
end.compact

def median(nums)
  nums.sort[nums.length/2]
end

# puts score.sort.inspect

puts "Score = #{median score}"