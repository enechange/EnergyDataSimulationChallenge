Rails.application.routes.draw do

  root to: "welcome#index"

  resources :charge, controller: 'charges', only: :index
end
