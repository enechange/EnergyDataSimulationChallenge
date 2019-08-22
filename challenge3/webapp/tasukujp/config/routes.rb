Rails.application.routes.draw do

  get '/home/api/sum_graph_data.json', to: 'home#sum_graph_data'
  get '/home/api/avg_graph_data.json', to: 'home#avg_graph_data'

  root 'home#index'

end
