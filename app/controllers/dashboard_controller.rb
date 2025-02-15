class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
  end

  def borrow
    @book = Book.find(params[:id])

    if @book.available?
      @book.update(user: current_user)
      flash[:notice] = "You have successfully borrowed '#{@book.title}'."
    else
      flash[:alert] = "Sorry, this book is already borrowed."
    end

    redirect_to user_profile_path  # Redirect to user profile page
  end
end
