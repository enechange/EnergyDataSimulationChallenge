Rails.application.routes.draw do
  root 'houses#index'

  resources :houses, only: %i(index show)
  resources :energies, only: :index
  resource :temperature_chart, only: :show
end
