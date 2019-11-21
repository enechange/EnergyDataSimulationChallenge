Rails.application.routes.draw do
  root 'static_pages#top'
  get 'all', to: 'static_pages#all'
end
