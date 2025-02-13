class BorrowingsController < ApplicationController
  before_action :authenticate_user!


  # GET /borrowings (List all borrowings)
  def index
    borrowings = Borrowing.where(user: current_user).includes(:book)
    render json: borrowings.as_json(include: :book), status: :ok
  end

  # GET /borrowings/:id (Get a specific borrowing)
  def show
    render json: @borrowing
  end

  # POST /borrowings (Borrow a book)
  def create
    if @book.available
      @borrowing = Borrowing.new(
        user_id: params[:user_id],
        book_id: @book.id,
        borrowed_at: Time.current,
        due_date: 2.weeks.from_now,
        returned: false
      )

      if @borrowing.save
        @book.update(available: false) # Mark book as unavailable
        render json: @borrowing, status: :created
      else
        render json: @borrowing.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Book is already borrowed" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /borrowings/:id (Update borrowing details)
  def update
    if @borrowing.update(borrowing_params)
      render json: @borrowing
    else
      render json: @borrowing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /borrowings/:id (Return a book)
  def destroy
    @borrowing.update(returned: true)
    @borrowing.book.update(available: true) # Mark book as available
    render json: { message: "Book returned successfully" }, status: :ok
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Borrowing record not found" }, status: :not_found
  end

  def set_book
    @book = Book.find(params[:book_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Book not found" }, status: :not_found
  end

  def borrowing_params
    params.permit(:user_id, :book_id, :borrowed_at, :due_date, :returned)
  end
end

# Routes (config/routes.rb)
Rails.application.routes.draw do
  resources :borrowings, only: [ :index, :show, :create, :update, :destroy ]
end
