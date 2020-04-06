Rails.application.routes.draw do
  resources :cities, only: %i[index]
  resources :houses, only: %i[index]
  resources :datasets, only: %i[index]
end
