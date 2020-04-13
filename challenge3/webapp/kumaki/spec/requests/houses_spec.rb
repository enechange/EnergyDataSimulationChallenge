require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  it 'Houses一覧画面の表示に成功すること' do
    create(:house, firstname: 'Carolyn')
    get '/houses'
    expect(response).to have_http_status(200)
    expect(response.body).to include('Carolyn')
  end

  it 'House詳細画面の表示に成功すること' do
    dataset = create(:dataset, daylight: 178.9)
    get "/houses/#{dataset.house.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include('178.9')
  end
end
