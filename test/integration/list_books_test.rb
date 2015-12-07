require 'test_helper'

class ListBooksTest < ActionDispatch::IntegrationTest
  setup do
    Book.create!(title: "Pragmatic Programmer", rating: 5)
    Book.create!(title: "Ender's Game", rating: 5)
    # we want this to raise an error if it doesn't work
  end
  
  test "listing books" do
    get "/books"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal Book.count, JSON.parse(response.body).size
  end
end
