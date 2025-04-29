class AuthorsController < ApplicationController
  # This Controller lists all authors, optionally filtered by a search query.
  def index
    if params[:query].present?
      # If a search query is provided, find all the authors whose names contain the query
      # Tne order by name and paginate by 10 authors.
      @authors = Author.where("name LIKE ?",  "%#{params[:query]}%").order(:name).page(params[:page]).per(10)
    else
      # If no retrieve all authors in alphabetical order and paginated.
      @authors = Author.order(:name).page(params[:page]).per(10)
    end
  end

  def show
    # Finds a single author using the id
    @author = Author.find(params[:id])
  end
end
