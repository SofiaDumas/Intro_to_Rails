class Book < ApplicationRecord
  validates :title, presence: true

  belongs_to :author, optional: true
  belongs_to :publisher, optional: true

  has_many :book_genres
  has_many :genres, through: :book_genres
end
