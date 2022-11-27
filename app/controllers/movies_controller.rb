class MoviesController < ApplicationController
  
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
    
  def index
    @movies = Movie.released
  end
  
  def show
    @review_count = @movie.reviews.size
    @review = @movie.reviews.new
    @fans = @movie.fans
    if current_user
      @favourite = current_user.favourites.find_by(movie_id: @movie.id)
    end
    @genres = @movie.genres,order(:name)
  end
  
  def edit
  end
  
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other, alert: "Movie successfully deleted!"
  end
  
  private
  
  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross,
        :director, :duration, :email_file_name)
  end
  
  def set_movie
    @movie = Movie.find(params[:id])
  end
end
