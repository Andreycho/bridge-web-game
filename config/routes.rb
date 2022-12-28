Rails.application.routes.draw do
  
  root 'sessions#home'

  #User routes
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]

  #Session routes
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

end
