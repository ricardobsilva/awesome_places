# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: 'sessions'
  }

  resources :places, only: :create
  resources :assessments, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
