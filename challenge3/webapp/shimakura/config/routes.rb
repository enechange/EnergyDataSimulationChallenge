Rails.application.routes.draw do
  root to: 'houses#index'
  resources :energies
  resources :houses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
