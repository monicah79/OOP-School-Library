require_relative './app'

# rubocop:disable Metrics

def main
  app = App.new
  loop do
    puts 'Welcome to the OOP School Library App'
    puts
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals'
    puts '7 - Exit'
    puts

    option = gets.chomp.to_i
    case option
    when 1
      app.list_all_books
    when 2
      app.list_all_people
    when 3
      app.create_a_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.list_all_rentals
     
    when 7
      puts 'Thank you for using this app!'
      exit
    else
      puts 'invalid option, Please choose a number between 1 and 7'
    end
  end
end

# rubocop:enable Metrics

main
