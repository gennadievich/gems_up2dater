Rails.application.routes.draw do
  root :to => "home#index"

  get "/home/index" => "home#index", as: :home
end
