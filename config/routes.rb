Rails.application.routes.draw do
  devise_for :users, :controllers => { :sessions => "users/sessions" }

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'  
  end

  resources :games
  resources :playables

  root 'home#index'
  
  # post '/draw', to: 'games#draw', as: 'draw_button'
  # get '/draw', to: redirect('games#root')
  # post '/shuffle', to: 'games#shuffle', as: 'shuffle_button'
  # get '/shuffle', to: redirect('games#root')
  # post '/show', to: 'games#show', as: 'show_button'
  # get '/show', to: redirect('games#root')

  mount ActionCable.server => '/cable'
end
