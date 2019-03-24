Rails.application.routes.draw do
  root "datas#index"
  resources :datas, only: [:index] do
    resources :users, only: [:index]
  end
end
