input = File.readlines('./2021-10-input.txt').map(&:chomp)

Score = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

IsOpen = ["(", "[", "{", "<"]
Matching = {")" => "(", "]" => "[", "}" => "{", ">" => "<"}

def score_line(chars)
  stack = []

  chars.each do |char|
    if IsOpen.include?(char)
      stack << char
    elsif Matching[char] == stack[-1]
      stack.pop
    else
      puts "Char = #{ char}, Expected #{Matching[char]}, found #{stack[-1]}"
      return Score[char] || 0
    end
  end

  0
end

score = input.map do |line|
  chars = line.split('')

  score_line(chars)
end

puts "Score = #{score.sum}"