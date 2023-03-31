require_relative './nameable'
require_relative './capitalize_decorator'
require_relative './trimmer_decorator'
class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def of_age?
    @age >= 18
  end

  def correct_name
    @name
  end
end

# Testing
person = Person.new(22, 'maximilianus')
puts person.correct_name
capitalized_person = capitalize_decorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = trimmer_decorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
