require_relative '../book'
require 'rspec'

RSpec.describe 'Create a book' do
  book = Book.new('My Life In Crime', 'John Kiriamiti')

  it 'Has a title' do
    expect(book.title).to eq('My Life In Crime')
  end

  it 'Has an author' do
    expect(book.author).to eq('John Kiriamiti')
  end
end