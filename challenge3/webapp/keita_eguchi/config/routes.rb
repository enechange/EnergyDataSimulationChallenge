Rails.application.routes.draw do
  root 'energies#index'
  resources :houses, only: [:index]
  resources :energies, only: [:index]
end
