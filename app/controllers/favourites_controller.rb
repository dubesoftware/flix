class FavouritesController < ApplicationController
  
  before_action :require_signin
  
  def create
    set_movie
    @movie.fans << current_user
    redirect_to @movie
  end
  
  def destroy
    favourite = current_user.favourites.find(params[:id])
    favourite.destroy
    
    set_movie
    redirect_to @movie
  end
  
  private
  
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
