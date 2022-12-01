require 'pp'

lines = File.readlines("./2020-04-input.txt").map(&:strip)

Keys = %w(byr iyr eyr hgt hcl ecl pid)

EyeColors = %w(amb blu brn gry grn hzl oth)

current = []
passportLines = [current]

lines.each do |line|
  if line == ''
    current = []
    passportLines << current
  else
    current << line
  end
end

puts "Found #{ passportLines.length} passports:"
puts "=" * 40

def parsePassport(passport)
  parsed = {}
  info = passport.join(" ").split(/\s+/).map { |string| string.split(":") }
  info.each { |(k, v)| parsed[k] = v }
  parsed
end

def is_valid?(passport)
  Keys.all? { |key| passport[key] } &&
  is_valid_number?(passport["byr"], 1920, 2002) &&  # /19[2-9]\d|200[0-2]/
  is_valid_number?(passport["iyr"], 2010, 2020) &&  # /20(1\d|20)/
  is_valid_number?(passport["eyr"], 2020, 2030) &&  # /20(2\d|30)/
  is_valid_height?(passport["hgt"]) &&
  is_valid_hex?(passport["hcl"]) &&
  is_valid_eye_color?(passport["ecl"]) &&
  is_valid_id?(passport["pid"])
end

def is_valid_number?(string, min, max)
  string.to_i >= min && string.to_i <= max
end

def is_valid_height?(string)
  if string =~ /(\d+)cm/
    is_valid_number?($1, 150, 193) # /1([5-8]\d|9[0-3])/
  elsif string =~ /(\d+)in/
    is_valid_number?($1, 59, 76)   # /59|6\d|7[0-6]/
  else
    false
  end
end

def is_valid_hex?(string)
  string =~ /^#[a-f0-9]{6}$/
end

def is_valid_eye_color?(string)
  EyeColors.include?(string)
end

def is_valid_id?(string)
  string =~ /^\d{9}$/
end

validCount = 0

passportLines.each do |rows|
  passport = parsePassport(rows)
  pp passport
  puts "-" * 40
  if is_valid?(passport)
    puts "VALID"
    validCount += 1
  else
    puts "INVALID"
  end
  puts "=" * 40
end

puts "Found #{ validCount } valid passports"
