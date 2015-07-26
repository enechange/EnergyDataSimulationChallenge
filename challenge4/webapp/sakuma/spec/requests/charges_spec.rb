require 'rails_helper'

RSpec.describe "Charges", type: :request do

  describe "GET /charge" do

    before { get charge_index_path, body, headers }

    context 'html format' do
      let(:headers) { nil }
      let(:body) { nil }

      it "works!" do
        expect(response.body).to be_include "Please access JSON request"
      end
    end

    context 'json format' do
      let(:headers){
        {
          'CONTENT_TYPE' => 'application/json',
          'ACCEPT' => 'application/json',
        }
      }
      let(:body) { {}.to_json }

      it { expect(response).to have_http_status(200) }

      it "valid response json body" do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(
          {
            status: 200,
            message: 'Successful HTTP requests.',
            request_id: request.uuid,
            energy_charges: [
              {plan_name: 'A', price: 3210},
              {plan_name: 'B', price: 2345},
            ]
          }
        )
      end
    end

  end

end

