require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  describe 'GET /' do
    before do
      get root_path
    end

    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end

    it 'タイトルが表示されていること' do
      expect(response.body).to include "Energy Data Simulation Challenge3"
    end
  end

  describe 'GET houses#show' do
    let(:house) { create(:house_1) }

    before do
      get house_path(house.id)
    end

    it '名前が表示されていること' do
      within '.table' do
        expect(response.body).to include "#{house.first_name} #{house.last_name}"
      end
    end
  end
end
