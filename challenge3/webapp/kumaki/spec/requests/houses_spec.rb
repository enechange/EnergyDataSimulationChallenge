require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  it 'Houses一覧画面の表示に成功すること' do
    create(:house, firstname: 'Carolyn')
    get '/houses'
    expect(response).to have_http_status(200)
    expect(response.body).to include('Carolyn')
  end
end
