Rails.application.routes.draw do
  root 'homes#index'

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :house, only: %i[index]
      resources :energy, only: %i[index]
    end

    get '*path', to: 'homes#index'
  end
end
