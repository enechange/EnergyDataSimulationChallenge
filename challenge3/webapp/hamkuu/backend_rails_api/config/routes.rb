Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  namespace :api do
    namespace :v1 do
      get 'energy-data/house-owners', action: :index, controller: 'house_owners'
      get 'energy-data/houses', action: :index, controller: 'houses'
      get 'energy-data/household-energy-records', action: :index, controller: 'household_energy_records'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
