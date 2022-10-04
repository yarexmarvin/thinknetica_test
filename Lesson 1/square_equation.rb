puts "Enter a number 1 for an equation:"
num1 = gets.chomp.to_f

puts "Enter a number 2 for an equation:"
num2 = gets.chomp.to_f

puts "Enter a number 3 for an equation:"
num3 = gets.chomp.to_f


discriminant = (num2**2 - 4*num1*num3)

if discriminant < 0

  puts "уравнение не имеет решений"

elsif discriminant == 0

  result = -num2 / (2*num1)
  puts "ответ: #{result}"

else
  result1 = (-num2 + Math.sqrt(discriminant))/(2*num1)
  result2 = (-num2 - Math.sqrt(discriminant))/(2*num1)
  
  puts "ответы: х1=#{result1} х2=#{result2}"

end
