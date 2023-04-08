# require_relative './nameable'
# require_relative './capitalize_decorator'
# require_relative './trimmer_decorator'
# class Person < Nameable
#   attr_accessor :name, :age
#   attr_reader :id

#   def initialize(age, name = 'Unknown', parent_permission: true)
#     super()
#     @id = Random.rand(1..1000)
#     @age = age
#     @name = name
#     @parent_permission = parent_permission
#     @rentals = []
#   end

#   def can_use_services?
#     of_age? || @parent_permission
#   end

#   def of_age?
#     @age >= 18
#   end

#   def correct_name
#     @name
#   end

#   def add_rental(book, date)
#     Rental.new(date, self, book)
#   end
# end

# Testing
# person = Person.new(22, 'maximilianus')
# puts person.correct_name
# capitalized_person = capitalize_decorator.new(person)
# puts capitalized_person.correct_name
# capitalized_trimmed_person = trimmer_decorator.new(capitalized_person)
# puts capitalized_trimmed_person.correct_name

require_relative './nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :books, :rentals

  def initialize(age:, parent_permission: true, name: 'Unknown')
    super()
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = Random.rand(1..1000)
    @rentals = []
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

  def correct_name
    @name.correct_name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def to_h
    {
      name: @name,
      id: @id,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals.map(&:to_h)
    }
  end

  private

  def of_age?
    @age >= 18
  end
end
