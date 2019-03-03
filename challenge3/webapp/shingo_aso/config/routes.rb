Rails.application.routes.draw do
  get 'houses/index'
  resources 'houses', only: :index do
    collection { post :import }
  end

  root 'energies#index'
  resources 'energies', only: :index do
    collection { post :import }
  end
end
