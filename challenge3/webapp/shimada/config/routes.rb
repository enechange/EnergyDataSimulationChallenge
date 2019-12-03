Rails.application.routes.draw do
  resources :houses, only: :index
  root 'energies#index'
end
