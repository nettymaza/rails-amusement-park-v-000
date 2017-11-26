Rails.application.routes.draw do

  # Root 'home' controller
  root "welcome#home"

  # Users controller
  resources :users


  # Sessions controller
   get "/signin", to: "sessions#new"
   post "/sessions/create", to: "sessions#create"
   delete "/signout", to: "sessions#destroy"

  # Attractions controller
  resources :attractions

  # Rides controller
  post "/rides/new", to: "rides#new"

end
