Rails.application.routes.draw do
  root 'houses#index'

  resources :energies, only: %i[index] do
    collection { post :import}
  end

  resources :houses, only: %i[index show] do
    collection { post :import}
  end
end
