class BooksController < ApplicationController
  def index
    books = Book.all
    render json: books
  end

  def create
    book =Book.new(book_params)
    if book.save
      render json: { message: "Book created successfully", book: book }, status: :created
    else
      render json: { errors: book.errors.full_message }, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :available)
  end
end
