
months_and_days = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

puts 'Enter day of the month:'
day = gets.chomp.to_i

puts 'Enter month of the year:'
month = gets.chomp.to_i

puts 'Enter a full year:'
year = gets.chomp.to_i


result = 0;

(1...month).each do |month|
  result += months_and_days[month]
end

result += day;

if year % 4 == 0 && year % 100 != 0
  result+=1

elsif year % 4 == 0 && year % 100 == 0
  if year % 400 == 0
    result +=1
  end

end


puts "It is the #{result} day of #{year} year!"


