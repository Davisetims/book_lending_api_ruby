class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :borrowings
  def profile
    @borrowings = current_user.borrowings.includes(:book)  # Get all borrowings for the current user
  end
end
