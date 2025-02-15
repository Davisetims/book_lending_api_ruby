class Book < ApplicationRecord
  belongs_to :user, optional: true
  has_many :borrowings
  validates :title, :author, presence: true

  # Method to check if the book is available
  def available?
    user.nil?
  end
end
