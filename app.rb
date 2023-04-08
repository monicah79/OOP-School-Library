require_relative './person'
require_relative './book'
require_relative './rental'
require_relative './student'
require_relative './teacher'
require_relative './classroom'
require_relative './nameable'
require_relative './data_file'
require 'json'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def create_book
    puts 'Enter book\'s title'
    title = gets.chomp
    puts 'Enter author\'s name'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts "Created #{book.title} by #{book.author}"
    # dataFile = DataFile.new
    # dataFile.create_book(book)
    save_data(@books, 'books.json')
    puts 'Book created successfully'
  end

  def list_all_books
    if @books.empty?
      puts 'The book list is currently empty'
    else
      puts 'Existing books'
      @books.each do |book|
        puts "Title: '#{book.title}', Author: '#{book.author}'"
      end
    end
  end

  def list_all_people
    @people = load_data('people.json')
    if @people.empty?
      puts 'The\'s list is currently empty!'
    else
      puts 'Existing people'
      @people.each do |person|
        puts "Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
      end
    end
  end

  def create_a_person
    puts 'Are you a:'
    puts '1 - Student'
    puts '2 - Teacher'
    option = gets.chomp.to_i
    case option
    when 1
      create_student
    when 2
      create_teacher
    else
      raise ' Invalid option, please enter 1 or 2'
    end
  end

  # def create_student
  #   puts 'Age:'
  #   age = gets.chomp.to_i
  #   puts 'name:'
  #   name = gets.chomp
  #   # 
  #   puts 'parent permission? [Y/N]:'
  #   student = Student.new(age, name, parent_permission)
  #   @people << student
  #   puts 'Student created successfully'
  # end

  def create_student
    age = request_age
    name = request_name
    parent_permission = request_parent_permission
    return if parent_permission.nil?
  
    student = Student.new(classroom: @classroom, age: age, parent_permission: parent_permission, name: name)
    @people << student
    save_data(@people, 'people.json')
    puts 'Student created successfully'
  end
  
  def request_age
    puts 'Age:'
    age = gets.chomp.to_i
    while age <= 0
      puts 'Invalid input. Please enter a positive number for age:'
      age = gets.chomp.to_i
    end
    age
  end
  
  def request_name
    puts 'Name:'
    name = gets.chomp
    while name.empty?
      puts 'Invalid input. Please enter a non-empty name:'
      name = gets.chomp
    end
    name
  end
  
  def request_parent_permission
    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.downcase
    until %w[y n].include?(parent_permission)
      puts 'Invalid input. Please enter Y or N:'
      parent_permission = gets.chomp.downcase
    end
    parent_permission == 'y'
  end
  sleep 0.5
  def create_teacher
    puts 'name:'
    name = gets.chomp
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'specialization:'
    specialization = gets.chomp
    teacher = Teacher.new(name, age, specialization)
    @people << teacher
    puts 'Teacher Successfuly created'
  end

  # def create_rental
  #    if @books.empty? && @people.empty?
  #     puts 'sorry,Not found'
  # else
  #   puts 'select a book from the list'
  #   @books.each_with_index do |book, index|
  #     puts "#{index} - [book] |Tittle: #{book.title} Author: #{book.author}"
  #   end
  # end
  #   book_num = gets.chomp.to_i
  #   book_rented = @books[book_num]

  #   puts 'Select a person from the following list by number (not id)'
  #   @people.each_with_index do |person, index|
  #     puts "#{index} - [Student] Id: #{person.id} Name: #{person.name} Age: #{person.age}" if person.is_a?(Student)
  #     puts "#{index} - [Teacher] Id: #{person.id} Name: #{person.name} Age: #{person.age}" if person.is_a?(Teacher)
  #   end

  #   person_num = gets.chomp.to_i
  #   person_renting = @people[person_num]

  #   print 'Enter date of renting the book (yyyy-mm-dd): '
  #   date = gets.chomp.to_s

    
  #   rental = Rental.new(date, book_num, book_rented)
  #   @rentals << rental
  #   puts 'The book has been successfully rented!'
  # end
  
  #   sleep 0.5
  # end

  def create_rental
    puts 'Select a book from the list'
    @book = load_data('books.json')
    @book.each_with_index do |book, index|
      puts "#{index}) Title: #{book['title']}, Author: #{book['author']}"
    end
    rental_book = gets.chomp.to_i

    puts 'Select a person from list'
    @people = load_data('people.json')
    @people.each_with_index do |person, index|
      puts "#{index}) Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
    rental_person = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, @people[rental_person], @book[rental_book])
    @rentals.push(rental)
    save_data(@rentals, 'rental.json')
    puts 'Rental created successfully'
  end
end

  def select_book
    puts 'Select a book by its number:'
    @books.each_with_index do |book, index|
      puts "Number: #{index + 1} - Title: #{book.title}, Author: #{book.author}"
    end
    book_id_input = gets.chomp.to_i
    return nil if book_id_input < 1 || book_id_input > @books.size

    @books[book_id_input - 1]
  end

  def select_person
    puts 'Select the person renting the book by their number:'
    @people.each_with_index do |person, index|
      puts "Number: #{index + 1} - Role: #{person.class.name}, Name: #{person.name}, ID: #{person.id}"
    end
    person_id_input = gets.chomp.to_i

    return nil if person_id_input < 1 || person_id_input > @people.size

    @people[person_id_input - 1]
  end

  def input_rental_date
    puts 'Enter the rental date [yyyy-mm-dd]:'
    gets.chomp
  end

  public

  def list_all_rentals()

    @rental =  load_data('rental.json')

    # rentals = @rentals.select { |rental| rental.person.id == person_id }
      print 'ID of person: '
    id = gets.chomp.to_i
    @rental.each do |rental|
      if id == rental['person']['id']
      
        puts "Date: #{rental['date']}, Book: #{rental['book']['title']}, by #{rental['book']['author']}"
      end
    end
  end

