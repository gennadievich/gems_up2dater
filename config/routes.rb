Rails.application.routes.draw do
  root :to => "home#index"

  get  "/login" => "sessions#index", as: :login
  post "/login" => "sessions#create"
  get  "/logout" => "sessions#destroy", as: :logout

  get  "/register" => "users#new", as: :register
  post "/register" => "users#create"

  get "/home/index" => "home#index", as: :home_page

  resources :users
end
