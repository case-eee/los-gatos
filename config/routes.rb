Rails.application.routes.draw do

  get "/" => "cats/votes#index"

  namespace :admin do
    get "cats/cute_votes", to: "cats#cute_votes", as: :cute_votes
    get "cats/amazing_votes", to: "cats#amazing_votes", as: :amazing_votes
    resources :cats
    get "login", to: "sessions#login", as: :login
    delete "logout", to: "sessions#logout", as: :logout
    post "sessions", to: "sessions#create", as: :sessions
  end

  namespace :cats do
    resources :votes, only: [:index]
    post "votes/create_amazing", to: "votes#create_amazing", as: :create_amazing
    post "votes/create_cute", to: "votes#create_cute", as: :create_cute
  end
end
