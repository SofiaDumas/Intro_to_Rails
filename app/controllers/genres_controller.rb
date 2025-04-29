class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genres = Genre.order(:name).page(params[:page]).per(5)
  end

  def show
    @genre = Genre.find(params[:id])
  end
end
