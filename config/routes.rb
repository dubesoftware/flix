Rails.application.routes.draw do
  resources :genres
  root "movies#index"
  
  resources :movies do
    resources :reviews
    resources :favourites, only: [:create, :destroy]
  end
  
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  
  resource :session, only: [:new, :create, :destroy]
  
  resources :users
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
