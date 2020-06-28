Rails.application.routes.draw do
  get 'houses/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :houses
  resources :energies
end
