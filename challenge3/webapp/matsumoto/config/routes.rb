Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "energies#index"
  resources :energies, only: [:index, :show] do
  end

  get 'cities/energies', to: 'cities#energies'
  get 'houses/energies', to: 'houses#energies'
end
