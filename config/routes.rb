Rails.application.routes.draw do
  root "movies#index"
  resources :favourites
  
  resources :movies do
    resources :reviews
  end
  
  resource :session, only: [:new, :create, :destroy]
  
  resources :users
  get "signup" => "users#new"
  get "signin" => "sessions#new"
end
