Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [ :index, :create, :update, :destroy ]
  resources :borrowings, only: [ :index, :show, :create, :update, :destroy ]
end
