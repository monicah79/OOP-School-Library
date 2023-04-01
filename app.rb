require_relative './person'
require_relative './book'
require_relative './rental'
require_relative './student'
require_relative './teacher'
require_relative './classroom'
require_relative './nameable'

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
    if @people.empty?
      puts 'The\'s list is currently empty!'
    else
      puts 'Existing people'
      @people.each do |person|
        puts "Name: #{person.name} Age: #{person.age} ID: #{person.id}"
      end
    end
  end

  def create_a_person
    puts 'Are you a:'
    puts '1 - Student'
    puts '2 - Teacher'


    case option
    when 1
      create_student
    when 2
      create_teacher
    else
      raise ' Invalid option, please enter 1 or 2'
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'name:'
    name = gets.chomp
    puts 'classroom:'
    classroom = gets.chomp

    puts 'parent permission? [Y/N]:'


    student = Student.new(age, classroom, name, true)
    @people << student
    puts 'Student created successfully'
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

  def create_rental
    puts 'sorry,Not found' if @books.empty? && @people.empty?
    date = input_rental_date
    rental = Rental.new(date, book, person)
    @rentals << rental
    puts 'The book has been successfully rented!'
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

  def list_all_rentals(person_id)
    rentals = @rentals.select { |rental| rental.person.id == person_id }
    if rentals.empty?
      puts 'No rentals found for the given person ID!'
    else
      rentals.each do |rental|
        puts "#{rental.book.title} by #{rental.book.author}, rented on #{rental.date}"
      end
    end
  end
end
