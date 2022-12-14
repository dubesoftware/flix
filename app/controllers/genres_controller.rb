class GenresController < ApplicationController
  
  before_action :set_genre, only: [:edit, :show, :update, :destroy]
  before_action :require_admin, except: [:index, :show]
  
  def index
    @genres = Genre.by_created_at_desc
  end
  
  def show
    @movies = @genre.movies
  end
  
  def new
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_url, notice: "New genre \"#{@genre.name}\" created!"
    else
      render :new, status: :unprocessable_entity
    end
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
    @genre = Genre.find_by(slug: params[:id])
  end
end
