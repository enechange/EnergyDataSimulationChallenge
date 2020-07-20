Rails.application.routes.draw do
  root 'homes#index'

  namespace :api, format: 'json' do
    namespace :v1 do
      get 'dashboard', to: 'dashboard#index'
      resources :house, only: %i[index]
      resources :energy, only: %i[index]
    end

   get '*path', to: 'homes#index'
  end
end
