require 'rails_helper'

RSpec.describe PlansController, :type => :controller do
  describe "#calculate" do
    before do
      request.env["CONTENT_TYPE"] = 'application/json'
      request.env["HTTP_ACCEPT"]  = 'application/json'
    end

    let(:input) { [([0.1] * 24)] * 30 }
    let(:input_json) { {usage: input}.to_json }

    it "returns 200" do
      post :calculate, input_json
      expect(response.status).to eq(200)
    end

    it "returns 200" do
      post :calculate, input_json
      expect(response.header['Content-Type']).to include 'application/json'
    end

    describe "Response body" do
      before do
        post :calculate, input_json
        @res = JSON.parse(response.body)
      end

      it "returns Array of Hash" do
        expect(@res).to be_a Array
        expect(@res.first).to be_a Hash
      end

      it "returns Array of Hash" do
        expect(@res.count).to be 2
      end
    end

    describe "with fixture" do
      let(:input) { puts "fixture_path #{fixture_path}" }
    end
  end
end
