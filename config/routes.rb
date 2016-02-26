Rails.application.routes.draw do
  root :to => "home#index"

  get  "/login" => "sessions#index", as: :login
  post "/login" => "sessions#create"
  get  "/logout" => "sessions#destroy", as: :logout

  get  "/register" => "users#register", as: :register
  post "/register" => "users#create"

  get  "/all_projects" => "projects#all_projects", as: :all_projects

  get "/home/index" => "home#index", as: :home_page

  resources :users do
    resources :projects do
      member do
        post :create_gem
      end
    end
  end

  resources :ruby_gems
end
