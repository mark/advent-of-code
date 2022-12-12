lines = File.readlines('./input.txt').map(&:chomp)

Rules = {}
Messages = []

def parse_rule(rule)
  if rule =~ /"(.)"/
    { literal: $1 }
  elsif rule =~ /(.+) [|] (.+)/
    { alternates: [parse_rule($1), parse_rule($2)] }
  else
    { sequence: rule.split(' ').map(&:strip) }
  end
end

def process(message, rule_name, idx)
  rule = Rules[rule_name]

  if rule[:literal]
    message[idx] == rule[:literal] ? idx+1 : nil
  elsif rule[:sequence]
    
end

def valid_message?(message)
  process(message, "0", 0) == message.length
end

lines.each do |line|
  if line =~ /(\d+): (.+)/
    Rules[$1] = parse_rule($2)
  elsif line =~ /[ab]+/
    Messages << line
  end
end

puts Rules.inspect

Messages.count { |message| valid_message?(message) }