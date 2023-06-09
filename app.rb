#!/usr/bin/env ruby
require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'

class App
  attr_reader :books, :people, :rental

  def initialize(books = [], people = [], rental = [])
    @books = books
    @people = people
    @rental = rental
  end

  def all_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def all_people
    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  end

  # rubocop:disable Metrics/MethodLength
  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    option_person = gets.chomp
    print 'Age: '
    age = gets.chomp
    age = 18 if age == ''
    print 'Name: '
    name = gets.chomp
    name = 'Unknown' if name == ''

    case option_person
    when '1'
      print 'Has parent permission? [Y/N]: '
      has_parent_permission = gets.chomp
      has_permission = has_parent_permission.downcase == 'y'
      puts "#{name}, #{age}, #{has_permission}"
      person = Student.new(age: age, name: name, parent_permission: has_permission)

    when '2'
      print 'Specialization: '
      specialization = gets.chomp
      specialization = 'Unknown' if specialization == ''
      person = Teacher.new(age: age, specialization: specialization, name: name)
    else
      puts 'Sorry, you choose a wrong option'
      return
    end
    @people << person unless @people.include?(person)
    puts 'Person created successfully'
  end
  # rubocop:enable Metrics/MethodLength

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book unless @books.include?(book)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    number_book = gets.chomp
    puts
    puts 'Select a person from the following list by number(not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    number_people = gets.chomp
    puts
    print 'Date: '
    date = gets.chomp
    rental = Rental.new(date, @people[number_people.to_i], @books[number_book.to_i])
    @rental << rental unless @rental.include?(rental)
  end

  def all_rentals_id
    print 'ID of person: '
    id = gets.chomp
    rental_of_person = @rental.filter { |rental| rental.person.id == id.to_i }
    puts 'Rentals: '
    rental_of_person.each do |rental|
      puts "Date: #{rental.date}, Book:\"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end
