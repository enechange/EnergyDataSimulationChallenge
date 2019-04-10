# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'cities#index'
  resources :cities, only: %i[index show] do
    member do
      get :for_scatter
    end
  end
  resources :houses, only: %i[index show] do
    member do
      get :for_scatter
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
