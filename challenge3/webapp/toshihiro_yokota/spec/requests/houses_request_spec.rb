require 'rails_helper'

RSpec.describe "Houses", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/houses/index"
      expect(response).to have_http_status(:success)
    end
  end

end
