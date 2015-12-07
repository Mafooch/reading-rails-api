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

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: 201, location: book
      # rails lets us generate a url for that book using location
    else
      render json: book.errors, status: 422
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy!
    render nothing: true, status: 204
  end

  def book_params
    params.require(:book).permit(:title, :rating)
  end
end
