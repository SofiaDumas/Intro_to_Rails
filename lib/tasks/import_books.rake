namespace :books do
  desc "Import books from Open Library API for multiple genres (ISBN optional)"
  task import_open_library: :environment do
    genres = [ "fantasy", "romance", "mystery", "science", "history", "poetry", "adventure" ]

    genres.each do |genre|
      puts "Fetching books for genre: #{genre}"
      results = OpenLibraryService.search_books(genre)

      results.each do |data|
        title = data["title"]
        next unless title.present?  # At minimum, must have a title

        # Author
        author_name = data["author_name"]&.first
        author = Author.find_or_create_by(name: author_name) if author_name.present?

        # Publisher
        publisher_name = data["publisher"]&.first
        publisher = Publisher.find_or_create_by(name: publisher_name) if publisher_name.present?

        # Book (use title + author for uniqueness since ISBN is optional)
        book = Book.find_or_create_by(title: title, author_id: author&.id) do |b|
          b.cover_image = nil
          b.isbn = data["isbn"]&.first
          b.publisher_id = publisher&.id
        end

        # Genres (subjects from API)
        genre_names = data["subject"] || []
        genre_names.first(3).each do |genre_name|
          g = Genre.find_or_create_by(name: genre_name)
          BookGenre.find_or_create_by(book: book, genre: g)
        end

        puts "Imported: #{book.title} (#{book.isbn || 'no ISBN'})"
      end
    end

    puts "Done importing books with or without ISBN!"
  end
end
