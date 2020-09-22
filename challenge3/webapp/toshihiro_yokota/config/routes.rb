Rails.application.routes.draw do
  root 'static_pages#index'

  resources :houses, only: [:index]
  resources :cities, only: [:index]
end
