Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "games#index"

  get "games", to:"games#auto_generation", as:"auto_generation"
  post "games", to:"games#manual_fill", as: "manual_fill"
  post "games/auto_fill", to:"games#auto_fill", as: "auto_fill"

end
