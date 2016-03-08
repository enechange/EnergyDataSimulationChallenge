require 'rails_helper'

RSpec.describe PlansController, :type => :controller do
  describe "#calculate" do
    before do
      request.env["CONTENT_TYPE"] = 'application/json'
      request.env["HTTP_ACCEPT"]  = 'application/json'
    end

    let(:input) { [([0.3] * 24)] * 30 }
    let(:input_json) { {usage: input}.to_json }

    it "returns 200" do
      post :calculate, input_json
      expect(response.status).to eq(200)
    end

    it "returns 200" do
      post :calculate, input_json
      expect(response.header['Content-Type']).to include 'application/json'
    end
  end
end
