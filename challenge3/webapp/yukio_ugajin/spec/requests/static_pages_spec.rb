require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it '正常にレスポンスを返すこと' do
      get root_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /all' do
    it '正常にレスポンスを返すこと' do
      get all_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /city' do
    it '正常にレスポンスを返すこと' do
      get city_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /num_of_people' do
    it '正常にレスポンスを返すこと' do
      get num_of_people_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /has_child' do
    it '正常にレスポンスを返すこと' do
      get has_child_path
      expect(response).to have_http_status 200
    end
  end
end