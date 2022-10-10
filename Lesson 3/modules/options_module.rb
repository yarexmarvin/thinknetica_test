module Options
  EXIT_PROGRAM = "back"

  def show_options(title, options)
    puts "============================"
    puts title
    options.each_with_index { |option, index| puts "#{index + 1} - #{option}" }
    puts "============================"
    puts "Type 'back' to go back"
    puts "____________________________"
  end

  def show_no_subject(subject)
    puts '! - - - - - - - - - - !'
    puts "There is no #{subject}"
    puts '! - - - - - - - - - - !'
  end

  def print_wrong_option
    puts "###############################################"
    puts "This option does not exist, try a different one"
    puts "###############################################"
    return
  end

  def ask_user
    user_response = ""

    while user_response == ""
      user_response = gets.chomp
      if user_response.strip == ""
        puts "Enter your option or enter 'back' to go back!"
      end
    end

    return user_response
  end
end
