Rails.application.routes.draw do
  get 'home/index'
  get 'reports/temperature_timeline', to: 'reports#temperature_timeline'
  get 'reports/city_daylight', to: 'reports#city_daylight'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
