Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'contents#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
  }

  resources :api, only: [] do
    collection do
      get :city_list
      get :user_info
    end
  end

  # GraphiQL
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

end
