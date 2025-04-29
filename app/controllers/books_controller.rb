class BooksController < ApplicationController
  # This controller handles displaying the list of books
  def index
    # Displays a paginated list of all books
    # Fi a search query is provided, it filter the books by title.
    if params[:query].present?
      # Results are order alphabetically by title and paginated by 30.
      @books = Book.where("title LIKE ?", "%#{params[:query]}%").order(:title).page(params[:page]).per(30)
    else
      # If no query is done, retrieve all books
      @books = Book.includes(:author, :genres).order(:title).page(params[:page]).per(30)
    end
  end

  # Displays the details fo a specific book, including related author and genre.
  def show
    # Find the book by its id.
    @book = Book.find(params[:id])
  end
end
