require 'set'
lines = File.read("./2020-06-input-b.txt").split("\n\n")

# puts "=" * 40

counts = lines.map do |line|
  responses = line.split("\n")

  # questions = line.downcase.tr('^a-z', '').split('')
  # set = Set.new(questions)
  # puts line.downcase.tr('^a-z', '')
  # puts questions
  # puts set.to_a.sort.join(' ')
  # puts set.length
  # puts "=" * 40
  # set.length
  ('a'..'z').count { |c| responses.all? { |r| r[c] }}
end

puts counts.sum

puts File.read("./2020-06-input-b.txt").split("\n\n").map { |g| ('a'..'z').count { |c| g.split("\n").all? { |l| l[c] }}}.sum
