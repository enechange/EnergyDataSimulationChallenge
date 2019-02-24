Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :houses, only: [:new, :create]
  resources :energy_records, only: [:new, :create]
  resources :charts, only: [:index]
end