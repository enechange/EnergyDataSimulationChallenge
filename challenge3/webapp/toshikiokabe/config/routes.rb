Rails.application.routes.draw do
  root 'houses#index'
  resources :houses, only: %i[index show]
end
