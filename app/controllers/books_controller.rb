class BooksController < ApplicationController
  # layout "application"
  def index
    if params[:query].present?
      @books = Book.where("title LIKE ?", "%#{params[:query]}%").order(:title).page(params[:page]).per(30)
    else
      @books = Book.all.includes(:author, :publisher, :genres)
      @books = Book.order(:title).page(params[:page]).per(30)
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
