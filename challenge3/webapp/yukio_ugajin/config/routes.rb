Rails.application.routes.draw do
  root 'static_pages#top'
  get 'all',  to: 'static_pages#all',  defaults: { format: :json }
  get 'city', to: 'static_pages#city', defaults: { format: :json }
  get 'num_of_people', to: 'static_pages#num_of_people', defaults: { format: :json }
end
