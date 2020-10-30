class Library
  attr_reader :name,
              :checked_out_books,
              :authors,
              :checkouts

  def initialize(name)
    @name = name
    @checked_out_books = []
    @authors = []
    @checkouts = {}
  end

  def add_author(author)
    @authors << author
  end

  def books
    books = @authors.flat_map do |author|
      author.books
    end

    check_availability(books)    
  end

  def check_availability(books)
    books = books.select do |book|
      !checked_out_books.include?(book)
    end
  end

  def publication_time_frame_for(author)
    max = 0
    min = 10_000
    author.books.each do |book|
      pub_year = book.publication_year.to_i
      max = pub_year if pub_year > max
      min = pub_year if pub_year < min
    end

    {:start => min.to_s, :end => max.to_s}
  end

  def checkout(book)
    if books.include?(book) && !checked_out_books.include?(book)
      count_checkout(book)
      @checked_out_books << book
      true
    else
      false
    end
  end

  def count_checkout(book)
    if checkouts.key?(book)
      checkouts[book] += 1
    else
      checkouts[book] = 1
    end
  end

  def return(book)
    @checked_out_books.delete(book)
  end

  def most_popular_book
    most_popular = checkouts.max_by do |book, count|
      count
    end
    most_popular[0]
  end
end