class ReviewsController < ApplicationController
  
  before_action :set_movie
  
  def index
    @reviews = @movie.reviews.find(params[:id])
  end
  
  def edit
    @review = @movie.reviews.find(params[:id])
  end
  
  def new
    @review = @movie.reviews.new
  end
  
  def create
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_url(@movie), status: :see_other, alert: "Movie successfully deleted!"
  end
  
  private
  
  def review_params
    params.require(:review).permit(:name, :comment, :stars)
  end
  
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
