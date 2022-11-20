class ReviewsController < ApplicationController
  
  def index
    @movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews
  end
  
  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new
  end
  
  def create
    @movie = Movie.find(params[:movie_id])
    @review = movie.reviews.new(review_params)
  end
  
  private
  
  def review_params
    params.require(:review).permit([:name, :stars, :comment])
  end
end
