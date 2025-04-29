class GenresController < ApplicationController
  # This controller handles displaying the list of genres
  # Displays a paginated list of all genres, sorted alphabetically.
  def index
    # Fetch all genres, in alphabetical order and paginated by 5.
    @genres = Genre.order(:name).page(params[:page]).per(5)
  end

  # Displays details of a specific genre
  def show
    # Find the genre by its id
    @genre = Genre.find(params[:id])
  end
end
