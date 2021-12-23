Rails.application.routes.draw do
  resources :recipes, only: %i[index create]

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/signup', to: 'users#create'
  get "/me", to: "users#me"


  # resources :users
  # get '/login', to: 'recipes#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
