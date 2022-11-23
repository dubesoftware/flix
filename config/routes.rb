Rails.application.routes.draw do
  resources :favourites
  root "movies#index"
  
  resources :movies do
    resources :reviews
  end
  
  resource :session, only: [:new, :create, :destroy]
  
  resources :users
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
