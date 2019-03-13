Rails.application.routes.draw do
  root 'houses#index'
  resources :houses
  resources :energies
  
end
