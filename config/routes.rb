# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Web routes
  resources :prompts

  # API V1 routes
  namespace :api do
    namespace :v1 do
      resources :prompts, only: %i[index show]
      resources :schema,  only: %i[index]
    end
  end

  # Application root path
  root to: 'prompts#index'
end
