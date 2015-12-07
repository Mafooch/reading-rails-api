class BooksController < ApplicationController
  def index
    books = Book.all

    if rating = params[:rating]
      # good practice to not access params multiple times. extract to variable
      # or method so more readable
      books = books.where(rating: rating)
    end
    render json: books, status: 200
  end
end
