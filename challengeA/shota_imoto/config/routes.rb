Rails.application.routes.draw do
  root to: "simulators#index"
  resources :plans, only: [:new, :create]
  resources :providers, only: [:new, :create]
  resources :basic_charges, only: [:new, :create]
  resources :usage_charges, only: [:new, :create]
  resources :simulators do
    collection do
      get :simulate
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
