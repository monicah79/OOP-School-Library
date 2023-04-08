class Rental
  attr_reader :date, :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    person['rentals'] << self
    @book = book
    book['rentals'] << self

  end

  def to_h
    {
      date: @date,
      person: @person.to_h,
      book: @book.to_h
    }
  end
end


# 
