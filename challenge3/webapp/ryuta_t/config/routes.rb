Rails.application.routes.draw do
  root 'energies#index'

  resources :energies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
