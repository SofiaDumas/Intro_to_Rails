# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'net/http'
require 'json'

puts "Fetching books from Open Library API"
genres = [ 'fantasy', 'science_fiction', 'romance', 'mystery', 'horror', 'history', 'biography' ]

genres.each do |genre_name|
  puts "Fetching books for genre: #{genre_name.capitalize}..."

  url = "https://openlibrary.org/subjects/#{genre_name}.json?limit=50"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  genre_record = Genre.find_or_create_by(name: genre_name.capitalize)

  data['works'].each do |work|
    title = work['title']
    author_name = work['authors']&.first&.dig('name') || 'Unknown Author'
    author = Author.find_or_create_by(name: author_name)
    book = Book.find_or_create_by(title: title, author: author)

    unless book.genres.exists?(id: genre_record.id)
      book.genres << genre_record
    end
  end
end

puts "All books populated with genres!"
