require 'rails_helper'

RSpec.describe PlansController, :type => :controller do
  let(:input) { [([0.3] * 24)] * 30 }

  describe "#calculate" do
    it "returns 200" do
      post :calculate
      expect(response.status).to eq(200)
    end

    it "returns 200" do
      post :calculate
      expect(response.header['Content-Type']).to include 'application/json'
    end
  end
end
