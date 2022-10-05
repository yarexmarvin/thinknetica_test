



vowels = "аеоуяюиэёы"

result = {}

("а".."я").each_with_index do |letter, index|

  result[letter] = index + 1 if vowels.include? letter

end

puts result
