class Book < ApplicationRecord
  # Validates that the book must have a title before it can be saved
  validates :title, presence: true

  # Sets up a many-to-one relationship: a book belongs to an author.
  belongs_to :author, optional: true
  # Sets up a many-to-one relationship: a book belongs to a publisher.
  belongs_to :publisher, optional: true

  # Sets up a one-to-many relationship with the BookGenre join model.
  has_many :book_genres
  # Sets up a many-to-many relationship with genres through the book_genres table.
  has_many :genres, through: :book_genres
end
