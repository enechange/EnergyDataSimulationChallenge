Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'contents#index'

  resources :api, only: [] do
    collection do
      get :city_list
    end
  end

end
