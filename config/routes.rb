# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#new'
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  get '/app/*path', to: 'pages#new'

  get '/:digest', to: 'forwardings#new', as: :short
  resources :forwardings, only: :new

  namespace :api do
    namespace :v1 do
      resources :links, only: %i[create index]
    end
  end
end
