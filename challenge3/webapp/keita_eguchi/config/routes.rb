Rails.application.routes.draw do
  root 'energies#index'
  resources :energies, only: [:index]
  resources :houses, only: [:index]
end
