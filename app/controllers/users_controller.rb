class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @borrowings = current_user.borrowings.includes(:book)  # Get all borrowings of the current user
  end
end
