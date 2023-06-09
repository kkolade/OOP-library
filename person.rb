#!/usr/bin/env ruby
require_relative './rental'

class Nameable
  def correct_name
    raise NotImplementedError, "Subclasses must implement 'correct_name' method."
  end
end

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :rental, :id

  def initialize(age:, name: 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || parent_permission
  end

  private

  def of_age?
    @age >= 18
  end

  def add_rental(book, date)
    Rental.new(date, self, book)
  end
end

class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    super[0..9]
  end
end
