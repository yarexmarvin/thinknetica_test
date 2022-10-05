



purchases = {}



STOP_WORD1 = 'stop'
STOP_WORD2 = 'стоп'


loop do
 
  puts 'What have you bought today?'
  product = gets.chomp
  break if product == STOP_WORD1 || product == STOP_WORD2

  puts 'What was the price?'
  price = gets.chomp.to_f
  
  puts 'How much of it you have bought?'
  amount = gets.chomp.to_f

  purchases[product] = {
   price: price,
   amount: amount
  }

  puts "If you want to stop write 'stop' or 'стоп'"
  response = gets.chomp
  break if response == STOP_WORD1 || response == STOP_WORD2

end


total_expenses = purchases.values.reduce(0) do |acc, product|
  total = product[:price] * product[:amount]
  acc+=total
end

total_list = purchases.reduce({}) do |acc, (key, values)|
  acc[key] = values[:price]*values[:amount]
  acc
end
puts "Your total list of purchases \n  #{purchases}"
puts "Your total sum by a  purchase \n  #{total_list.inspect}"
puts "Your total expenses: #{total_expenses}"
