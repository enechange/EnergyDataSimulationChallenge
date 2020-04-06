require 'rails_helper'

RSpec.describe 'Cities', type: :request do
  it 'Cities一覧画面の表示に成功すること' do
    create(:city, name: 'London')
    get '/cities'
    expect(response).to have_http_status(200)
    expect(response.body).to include('London')
  end
end
