require 'rails_helper'

RSpec.describe 'Dataset', type: :request do
  it 'Datasets一覧画面の表示に成功すること' do
    create(:dataset, daylight: 178.9)
    get '/datasets'
    expect(response).to have_http_status(200)
    expect(response.body).to include('178.9')
  end
end
