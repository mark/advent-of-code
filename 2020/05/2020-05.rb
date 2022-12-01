lines = File.readlines('./2020-05-input.txt').map(&:strip)

def chars_to_i(string, one)
  string.split('').map { |c| c == one ? '1' : '0' }.join.to_i(2)
end

seat_ids = lines.map do |line|
  row, col = line[0...7], line[7..-1]

  row_i = chars_to_i(row, 'B')
  col_i = chars_to_i(col, 'R')

  puts "Row is #{row}, col = #{col}, row # = #{ row_i }, col # = #{ col_i }, id = #{ row_i * 8 + col_i }"
  row_i * 8 + col_i
end

max = seat_ids.max
puts "Max seat_id = #{ max }"

(1..max).each do |id|
  if seat_ids.include?(id+1) && seat_ids.include?(id-1) && ! seat_ids.include?(id)
    puts "Empty seat #{ id }"
  end
end