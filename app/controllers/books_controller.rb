# class BooksController < ApplicationController
#   before_action :set_book, only: [ :update, :destroy ]

#   def index
#     books = Book.all
#     render json: books
#   end

#   def create
#     book = Book.new(book_params)
#     if book.save
#       render json: { message: "Book created successfully", book: book }, status: :created
#     else
#       render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def update
#     if @book.update(book_params)
#       render json: { message: "Book updated successfully", book: @book }, status: :ok
#     else
#       render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     @book.destroy
#     render json: { message: "Book deleted successfully" }, status: :ok
#   end

#   private

#   def set_book
#     @book = Book.find(params[:id])
#   rescue ActiveRecord::RecordNotFound
#     render json: { error: "Book not found" }, status: :not_found
#   end

#   def book_params
#     params.require(:book).permit(:title, :author, :isbn, :available)
#   end
# end

class BooksController < ApplicationController
  before_action :authenticate_user!

  def borrow
    @book = Book.find(params[:id])

    # Check if the book is available
    if @book.available?
      # Create a new Borrowing record
      borrowing = Borrowing.new(
        user: current_user,
        book: @book,
        borrowed_at: Time.current,
        due_date: 2.weeks.from_now
      )

      if borrowing.save
        # Update the book to mark it as unavailable
        @book.update(available: false)
        flash[:notice] = "You have successfully borrowed '#{@book.title}'."
      else
        flash[:alert] = "Sorry, something went wrong. Please try again."
      end
    else
      flash[:alert] = "Sorry, this book is already borrowed."
    end

    redirect_to root_path # Redirects to the home page (root path)
  end
end
