
puts "Enter the 1st side of a triangle"
side1 = gets.chomp.to_i

puts "Enter the 2nd side of a triangle"
side2 = gets.chomp.to_i

puts "Enter the 3rd side of a triangle"
side3 = gets.chomp.to_i


is_equilateral = side1 == side2 && side2 == side3
is_equidistant = side1 == side2 || side2 == side3 || side1 == side3
is_rectangular = false

if side1 > side2 && side1 > side3
    is_rectangular = side1**2 == side2**2 + side3**2
elsif side2 > side3
  is_rectangular = side2**2 == side1**2 + side3**2
else
  is_rectangular = side3**2 == side1**2 + side2**2
end


puts "Этот треугольник:#{is_rectangular ? " прямоугольный": ""}#{is_equilateral ? " равносторонний и": ""}#{is_equidistant ? " равнобедренный":""}#{!is_rectangular && !is_equilateral && !is_equidistant ? " неправильный" : ""} "


