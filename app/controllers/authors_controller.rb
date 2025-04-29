class AuthorsController < ApplicationController
  def index
    if params[:query].present?
      @authors = Author.where("name LIKE ?",  "%#{params[:query]}%").order(:name).page(params[:page]).per(10)
    else
      @authors = Author.all
      @authors = Author.order(:name).page(params[:page]).per(10)
    end
  end

  def show
    @author = Author.find(params[:id])
  end
end
