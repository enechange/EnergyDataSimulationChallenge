Rails.application.routes.draw do
  root to: 'cities#index'

  resources :cities, only: [:index] do
    collection do
      get ":city_id/energies" => "cities#energies"
    end
  end
end
