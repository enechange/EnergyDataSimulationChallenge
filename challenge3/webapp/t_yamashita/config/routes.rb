Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'users#show'

  resources :users, only: :show do
    member do
      get :comparison
      get :self_sufficiency 
    end
  end

  resources :energies, only: [:new, :create]

  resources :power_consumptions, only: [:new, :create, :edit, :update, :delete, :destroy]

end