Rails.application.routes.draw do

  resources :users do
    get :upvote, on: :member
  end

  resources :friendships
  resources :messages

  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  root 'users#home'
  match '/users/new',  to: 'users#new', via: 'get'


end
