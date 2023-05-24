require './person'

class Student < Person
  def initialize(classroom)
    super(name, age, parent_permission)
    @classrom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
