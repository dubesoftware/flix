class GenresController < ApplicationController
  
  def index
    @genres = Genre.all
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
end
