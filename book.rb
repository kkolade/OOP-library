class Book
  attr_accessor :title
  attr_accessor :author
  attr_reader :rental

  def initialize(title, author)
    @title = title
    @author = author
    @rental = []
  end  
end