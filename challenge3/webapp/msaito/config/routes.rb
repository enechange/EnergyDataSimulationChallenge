Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "statics#index"
  resources :statics, only: [:index, :show]
end
