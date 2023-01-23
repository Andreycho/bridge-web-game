Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "users/sessions" }

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'  
  end

  post 'create_game', to: 'games#create'

  root 'home#index'
end
