Rails.application.routes.draw do

  root to: "welcome#index"

  match 'charge', to: 'charges#index', via: [:get, :post], as: :charge_index
end
