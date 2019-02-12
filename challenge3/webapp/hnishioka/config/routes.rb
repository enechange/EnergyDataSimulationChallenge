Rails.application.routes.draw do
  resources :house_energy_usages, only: %i(index show)
  root 'house_energy_usages#index'
end
