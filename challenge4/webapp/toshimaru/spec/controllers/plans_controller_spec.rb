require 'rails_helper'

RSpec.describe PlansController, :type => :controller do
  before do
    request.env["CONTENT_TYPE"] = 'application/json'
    request.env["HTTP_ACCEPT"]  = 'application/json'
  end

  describe "#calculate" do
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
      let(:input_path) { "#{fixture_path}/input" }

      describe "month usage (sample-input.json)" do
        let(:sample_input) { File.read("#{input_path}/sample-input.json") }

        before do
          post :calculate, sample_input
          @result = JSON.parse(response.body)
        end

        it "Meter-Rate Lighting B" do
          expect(@result.first["price"]).to eq 2532
        end

        it "Yoru Toku Plan" do
          expect(@result.second["price"]).to eq 2697
        end
      end

      describe "a day usage" do
        let(:sample_input2) { File.read("#{input_path}/sample-input-1day-usage.json") }

        before do
          post :calculate, sample_input2
          @result = JSON.parse(response.body)
        end

        it "Meter-Rate Lighting B" do
          expect(@result.first["price"]).to  eq 80
        end

        it "WIP" do
          expect(@result.second["price"]).to eq 86
        end
      end
    end
  end
end
