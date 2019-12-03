Rails.application.routes.draw do
  root to: 'home#index'
  get '/:id' => 'home#show'
end
