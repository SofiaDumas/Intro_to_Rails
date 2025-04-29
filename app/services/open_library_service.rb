require "httparty"

class OpenLibraryService
  include HTTParty
  base_uri "https://openlibrary.org"

  def self.search_books(query = "fiction")
    response = get("/search.json?q=#{query}")

    if response.success?
      response.parsed_response["docs"]
    else
      []
    end
  end
end
