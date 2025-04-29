class BookGenre < ApplicationRecord
  # Sets up the associations that the BookGenre record belongs to a single book
  # and belongs to a single genre.
  belongs_to :book
  belongs_to :genre
end
