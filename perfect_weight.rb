
CONST1 = 110
CONST2 = 1.15

puts "What is your name?"

user_name = gets.chomp

puts "What is your current height?"

user_height = gets.chomp.to_f

perfect_weight = (user_height - CONST1) * CONST2 


unless perfect_weight.positive?
  puts "Your weight is already optimal!"
else
  puts "Hello #{user_name}, your optimal weight is #{perfect_weight} kg "
end

