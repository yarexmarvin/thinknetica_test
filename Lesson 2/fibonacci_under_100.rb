numbers = []

index = 0

loop do
  if numbers.length == 0
    numbers << 0
  elsif numbers.length < 3
    numbers << 1
  elsif numbers.length > 2
    fib = numbers[index - 1] + numbers[index - 2]
    break if fib > 100

    numbers << fib
  end
  index += 1
end

puts numbers.inspect
