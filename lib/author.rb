class Author
  attr_reader :name,
              :books

  def initialize(data)
    @name = data[:first_name] + " " + data[:last_name]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @name = "#{@first_name} #{@last_name}"
    @books = []
  end

  def write(title, publication_date)
    book = Book.new({title: title, publication_date: publication_date, author_first_name: @first_name, author_last_name: @last_name})
    books << book
    book
  end
end