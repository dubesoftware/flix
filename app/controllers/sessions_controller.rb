class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
    else
    end
  end
  
  def destroy
  end
end
