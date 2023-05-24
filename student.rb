require './person'

class Student < Person
  def initialize(age, classroom, name = "Unknown", parent_permission = true)
    super(name, age, parent_permission)
    @classrom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
