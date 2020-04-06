require 'rails_helper'

RSpec.describe 'Cities', type: :request do
  it 'Cities一覧画面の表示に成功すること' do
    get '/cities'
    expect(response).to have_http_status(200)
  end
end
