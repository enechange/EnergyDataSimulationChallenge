Rails.application.routes.draw do
  get '/', to: 'graphs#index'
  get 'scatter', to: 'graphs#scatter'
  get 'line', to: 'graphs#line'
end
