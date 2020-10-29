require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/library'
require './lib/author'
require './lib/book'


class LibraryTest < Minitest::Test
  def setup
    @dpl = Library.new("Denver Public Library")
  end

  def test_it_exists	
    assert_instance_of Library, @dpl 
  end

  def test_it_has_attributes
    assert_equal "Denver Public Library", @dpl.name
    assert_equal [], @dpl.books
    assert_equal [], @dpl.authors
  end

  def test_it_can_add_authors_and_books
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    @dpl.add_author(charlotte_bronte)
    @dpl.add_author(harper_lee) 

    assert_equal [charlotte_bronte, harper_lee], @dpl.authors
    assert_equal [jane_eyre, professor, villette, mockingbird], @dpl.books
  end

  def test_publication_time_frame_for
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    
    bronte_time_frame = {:start=>"1847", :end=>"1857"}
    lee_time_frame =  {:start=>"1960", :end=>"1960"}
    
    @dpl.add_author(charlotte_bronte)
    @dpl.add_author(harper_lee)

    assert_equal bronte_time_frame, @dpl.publication_time_frame_for(charlotte_bronte)
    assert_equal lee_time_frame, @dpl.publication_time_frame_for(harper_lee)
  end

  def test_checkout_books_and_track_checked_out
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    
    assert_equal false, @dpl.checkout(mockingbird)
    
    @dpl.add_author(charlotte_bronte)
    @dpl.add_author(harper_lee)
    
    assert @dpl.checkout(jane_eyre)

    assert_equal [jane_eyre], @dpl.checked_out_books

    @dpl.checkout(villette)

    assert_equal [jane_eyre, villette], @dpl.checked_out_books
  end
end