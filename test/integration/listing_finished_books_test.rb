require 'test_helper'

class ListingFinishedBooksTest < ActionDispatch::IntegrationTest
  # here's where we start doing some content negotioation, i.e.
  # what response type do we want back
  setup do
    Book.create!(title: "Finished", finished_at: 1.day.ago)
    Book.create!(title: "Finished", finished_at: nil) # we'll have it set
    # to nil by default but we're just being explicit here in our tests
    # note that the new property we're adding is NOT a boolean. good
    # practice to use a datetime instead, so that if it was finished, we can see
    # when. killing two birds with one stone
    Book.create!(title: "Not Finished")
  end

  test "lists finished books in JSON" do
    # the second argument is for params, which we can leave blank,
    # whereas the third argument is for the content type we request
    get "/finished_books", {}, { "Accept" => "application/json" }

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body).size
  end

  test "lists finished books in XML" do
    get "/finished_books", {}, { "Accept" => "application/xml" }

    assert_equal 200, response.status
    assert_equal Mime::XML, response.content_type

    assert_equal 1, Hash.from_xml(response.body)['books'].size # due to different xml formatting
  end
end
