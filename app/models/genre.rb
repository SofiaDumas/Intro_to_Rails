class Genre < ApplicationRecord
  # Validates that the genre must have a name before it can be saved.
  validates :name, presence: true

  # Sets up a one-to-many relationship with the BookGenre join model.
  has_many :book_genres
  # Sets up a many-to-many relationship with books through the book_genres table.
  has_many :books, through: :book_genres
end
