require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  # when creating integraation tests we wanna be at the feature level
  # not the controller level, which is why this isn't grouped with the other
  # books tests
  test "create a book with valid data" do
    post "/books", { book: {
      title: "Pragmatic Programmer",
      rating: 5,
      author: "Dave Thomas",
      genre_id: 1,
      review: "Excellent book for any programmer.",
      amazon_id: "13123"
    } }.to_json,
    { "Accept" => "application/json", # setting what type we expect
      "Content-Type" => "application/json" } # and type we're passing in }

    assert_equal 201, response.status
    # 201 means created
    assert_equal Mime::JSON, response.content_type

    book = json(response.body)[:book]
    assert_equal book_url(book[:id]), response.location
    # using the rails rout helper to generate the url for the book that we
    # get back. we want the reponse location header to equal this book url
    assert_equal "Pragmatic Programmer", book[:title]
    assert_equal 5, book[:rating].to_i
    assert_equal "Dave Thomas", book[:author]
    assert_equal 1, book[:genre_id]
    # assert_equal "Excellent book for any programmer.", book[:reivew]
    assert_equal "13123", book[:amazon_id]
  end

  test "does not create books with invalid data" do
    # we could be more explicit here and say attempts to create with missing
    # title, however that gets into validation testing which takes place a
    # the model level, whereas here we're just making sure the controller
    # can handle invalid post requests
    post "/books", { book:  {
      title: nil,
      rating: 4
      } }.to_json,
      { "Accept" => "Application/json",
        "Content-Type" => "Application/json" }

    assert_equal 422, response.status #status for invalid payload

  end
end
