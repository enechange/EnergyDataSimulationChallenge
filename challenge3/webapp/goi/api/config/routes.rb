Rails.application.routes.draw do
  root 'home#index'

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :house, only: %i[index]
      resources :energy, only: %i[index]
    end

    get '*path', to: 'home#index'
  end
end
