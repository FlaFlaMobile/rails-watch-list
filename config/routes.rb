Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "lists#index"
  
  # Un utilisateur peut voir toutes les listes
  get "/lists", to: "lists#index"

  # Un utilisateur peut créer une nouvelle liste
  get "/lists/new", to: "lists#new", as: :new_list
  post "/lists", to: "lists#create"
  
  # Un utilisateur peut voir les détails d’une liste donnée et son nom
  get "/lists/:id", to: "lists#show", as: :list

  delete "/lists/:id", to: "lists#destroy"
  
  # Routes pour les bookmarks, nestées sous les listes
  resources :lists do
    resources :bookmarks, only: [:new, :create]
  end
  
  resources :bookmarks, only: [:destroy]

end

# # Read all
#   get    "restaurants",          to: "restaurants#index"
#   # Create
#   get    "restaurants/new",      to: "restaurants#new",  as: :new_restaurant
#   post   "restaurants",          to: "restaurants#create"
#   # Read one - The `show` route needs to be *after* `new` route.
#   get    "restaurants/:id",      to: "restaurants#show", as: :restaurant
#   # Update
#   get    "restaurants/:id/edit", to: "restaurants#edit", as: :edit_restaurant
#   patch  "restaurants/:id",      to: "restaurants#update"
#   # Delete
#   delete "restaurants/:id",      to: "restaurants#destroy"