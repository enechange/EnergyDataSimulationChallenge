Rails.application.routes.draw do
  get 'houses/new'

  root 'houses#index'
  resources :houses, only: [:index]

  
end
