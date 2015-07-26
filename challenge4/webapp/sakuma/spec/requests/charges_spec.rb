require 'rails_helper'

RSpec.describe "Charges", type: :request do

  describe "GET /charge" do

    context 'html format' do
      before { get charge_index_path }
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
      let(:body) { YAML.load_file(Rails.root.join("spec/support/sample_consumptions/127.yml")).to_json }
      before { post charge_index_path, body, headers }

      it { expect(response).to have_http_status(200) }

      it "valid response JSON body" do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq({
          status: 200,
          message: 'Successful HTTP requests.',
          request_id: request.uuid,
          energy_charges: [
            {plan_name: 'Meter-Rate Lighting B', price: 2532},
            {plan_name: 'Yoru Toku Plan', price: 2135},
          ]
        })
      end
    end

  end

end

