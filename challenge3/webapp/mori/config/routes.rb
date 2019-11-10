Rails.application.routes.draw do
    
    root to: 'datas#index'
    resources :datas, only: [:index, :show]
end
