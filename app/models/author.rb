class Author < ApplicationRecord
  # Validate that the author's name is present
  validates :name, presence: true
  # Sets up a one-to-many association: An author can have many books
  has_many :books
end
