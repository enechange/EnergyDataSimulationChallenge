Rails.application.routes.draw do
  get '/', to: 'dashboard#index', trailing_slash: true
  get '/data.json', to: 'dashboard#show', trailing_slash: true
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
