months = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  oktober: 31,
  november: 30,
  december: 31
}

months.each do |month, days|
  has30Days = days == 30

  puts "#{month.to_s.capitalize} has #{days} days" if has30Days
end
