Rails.application.routes.draw do

  devise_for :users, path_names:{
    sign_up: ''
  }

  resources :users
  resources :notifications

  root to: 'dashboard#index'

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', as: 'users', controllers: {
      sessions: 'users/sessions'
    }
  end

end
