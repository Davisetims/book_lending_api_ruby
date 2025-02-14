Rails.application.routes.draw do
  get "home/index"
  root "home#index" # Set the homepage

  devise_for :users

  resources :books, only: [ :index, :create, :update, :destroy ]
  resources :borrowings, only: [ :index, :show, :create, :update, :destroy ]
end
