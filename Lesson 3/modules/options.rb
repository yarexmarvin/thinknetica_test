module Options
  EXIT_PROGRAM = %w[back 0]

  def show_options(title, options)
    puts '============================'
    puts title
    puts '0 - go back'
    options.each_with_index { |option, index| puts "#{index + 1} - #{option}" }
    puts '============================'
  end

  def show_no_subject(subject)
    puts '! - - - - - - - - - - !'
    puts "There is no #{subject}"
    puts '! - - - - - - - - - - !'
  end

  def print_wrong_option
    puts '###############################################'
    puts 'This option does not exist, try a different one'
    puts '###############################################'
    nil
  end

  def ask_user
    user_response = ''

    while user_response == ''
      user_response = gets.chomp
      puts "Enter your option or enter 'back' to go back!" if user_response.strip == ''
    end

    user_response
  end
end
