class BooksController < ApplicationController
  before_action :set_book, only: [ :update, :destroy ]

  def index
    books = Book.all
    render json: books
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: { message: "Book created successfully", book: book }, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: { message: "Book updated successfully", book: @book }, status: :ok
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    render json: { message: "Book deleted successfully" }, status: :ok
  end

  private

  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Book not found" }, status: :not_found
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :available)
  end
end
