# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  resources :places, only: %i[create index] do
    get 'assessments', on: :member
  end
  resources :assessments, only: :create
  resource :user, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
