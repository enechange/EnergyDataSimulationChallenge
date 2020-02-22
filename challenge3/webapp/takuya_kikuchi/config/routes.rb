Rails.application.routes.draw do
  root 'pages#main'
  get '/get_data', to: 'pages#get_data'
end
