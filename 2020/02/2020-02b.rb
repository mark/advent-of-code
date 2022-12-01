raw = File.readlines('./2020-02-input.log')

def is_valid?(password, req, first, second)
  char1 = password[first-1]
  char2 = password[second-1]

  (char1 == req && char2 != req) || (char1 != req && char2 == req)
end

REGEX = /^(\d+)-(\d+) ([a-z]): ([a-z]+)$/

valid_count = 0

raw.each do |line|
  if line =~ REGEX
    if is_valid?($4, $3, $1.to_i, $2.to_i)
      valid_count += 1
      puts "VALID:   #{line}"
    else
      puts "INVALID: #{line}"
    end
  else
    puts "???? #{ line }"
  end
end

puts "#{valid_count} valid passwords"
