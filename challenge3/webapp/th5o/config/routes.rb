Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'line_charts#show'

  resource :line_chart, only: %i(show)
  resource :bar_chart, only: %i(show)
  resources :houses, only: [:index, :show]
  resources :energies, only: [:index, :show]
end
