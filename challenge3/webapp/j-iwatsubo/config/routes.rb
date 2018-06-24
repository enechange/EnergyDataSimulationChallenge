Rails.application.routes.draw do
  get 'chart/index'
  get 'home/index'
  root to: 'home#index'

  resources :energy_productions
  resources :houses

  # redirect
  get "/energy_production" => redirect("/energy_productions")
  get "/house" => redirect("/houses")

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
