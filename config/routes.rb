Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "users/sessions" }

  resources :games
  resources :playables
  resources :turns
  resources :contract_turns

  root 'home#index'
  get '/history', to: 'home#history'
  
end
