# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#new'
  get '*path', to: 'pages#new'

  namespace :api do
    namespace :v1 do
      resources :links, only: :create
    end
  end
end
