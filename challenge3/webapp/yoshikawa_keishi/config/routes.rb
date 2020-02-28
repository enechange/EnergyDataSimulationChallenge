Rails.application.routes.draw do
  root "houses#index"
  resources :houses, only: [:index, :show]
end
