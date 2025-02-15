class BorrowingsController < ApplicationController
  before_action :authenticate_user!

  # GET /borrowings (List all borrowings)
  def index
    borrowings = Borrowing.includes(:book)  # Get all borrowings, including related books
    Rails.logger.debug(borrowings.inspect)  # This will log all borrowings
    render json: borrowings.as_json(include: :book), status: :ok
  end

  # POST /borrowings (Borrow a book)
  def create
    book = Book.find(params[:book_id])

    if book.available
      @borrowing = Borrowing.new(
        user: current_user,
        book: book,
        borrowed_at: Time.current,
        due_date: 2.weeks.from_now,  # Automatically set by the model callback
        returned: false
      )

      if @borrowing.save
        book.update(available: false) # Mark book as unavailable
        render json: @borrowing, status: :created
      else
        render json: @borrowing.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Book is already borrowed" }, status: :unprocessable_entity
    end
  end

  # PATCH /borrowings/:id/return_book (Return a borrowed book)
  def return_book
    @borrowing = Borrowing.find(params[:id])

    # Ensure the current user owns this borrowing and the book hasn't already been returned
    if @borrowing.user == current_user && !@borrowing.returned
      @borrowing.update(returned: true)
      @borrowing.book.update(available: true) # Mark the book as available again

      render json: { message: "You have successfully returned '#{@borrowing.book.title}'." }, status: :ok
    else
      render json: { error: "Unable to return the book or the book has already been returned." }, status: :unprocessable_entity
    end
  end
end
