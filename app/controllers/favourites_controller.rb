class FavouritesController < ApplicationController
  
  before_action :require_signin
  
  def create
    @movie = Movie.find(params[:movie_id])
    @movie.fans << current_user
    redirect_to @movie
  end
end
