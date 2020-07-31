Rails.application.routes.draw do
  root 'welcome#index'
  get 'csv/import'
  post 'csv/import'
  get 'csv/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
