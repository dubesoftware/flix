class GenresController < ApplicationController
  
  before_action :set_genre, only: [:edit, :update, :destroy]
  
  def index
    @genres = Genre.all
  end
  
  def show
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
    if @genre.update(genre_params)
      redirect_to genres_url, notice: "Genre successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @genre.destroy
    redirect_to genres_url, status: :see_other,
      alert: "Genre successfully deleted"
  end
  
  private
  
  def genre_params
    params.require(:genre).
      permit(:name)
  end
  
  def set_genre
    @genre = Genre.find(params[:id])
  end
end
