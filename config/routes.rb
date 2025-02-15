Rails.application.routes.draw do
  devise_for :users

  root to: "dashboard#index"

  resources :books, only: [ :index, :show ] do
    member do
      post "borrow"
    end
  end

  resources :borrowings, only: [ :index, :show, :create, :update ] do
    member do
      patch "return_book"  # Change from return_book to return (more RESTful)
    end
  end

  get "profile", to: "users#profile", as: "user_profile"
end
