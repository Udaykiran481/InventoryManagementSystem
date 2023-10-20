Rails.application.routes.draw do
  root 'sessions#new'
  resources :users
  resources :invitations
  resources :employees
  resources :brands
  resources :categories
  resources :items
  resources :issues 
  resources :invitations, only: [:new, :create, :edit, :update]
  resources :storage_items, only: [:index, :update]
  resources :notifications, only: [:index, :show]

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get '/accept_invitation/:invitation_token', to: 'invitations#accept', as: 'accept_invitation'


end
