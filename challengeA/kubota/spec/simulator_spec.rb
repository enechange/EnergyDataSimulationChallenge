require './spec/spec_helper'
require './lib/simulator'

RSpec.describe Simulator do
  let(:simulator) { described_class.new(contract_ampere, electric_energy_per_month) }

  describe 'tepco' do
    let(:provider_name) { '東京電力エナジーパートナー' }
    context 'when electric_energy_per_month is in the fisrt stage' do
      let(:electric_energy_per_month) { 120 }
      context 'when contract_amopere is 10A' do
        let(:contract_ampere) { 10 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 2671
        end
      end
      context 'when contract_amopere is 20A' do
        let(:contract_ampere) { 20 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 2957
        end
      end
    end
    context 'when electric_energy_per_month is in the second stage' do
      let(:electric_energy_per_month) { 300 }
      context 'when contract_amopere is 30A' do
        let(:contract_ampere) { 30 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 8010
        end
      end
      context 'when contract_amopere is 40A' do
        let(:contract_ampere) { 40 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 8296
        end
      end
    end
    context 'when electric_energy_per_month is in the third stage' do
      let(:electric_energy_per_month) { 301 }
      context 'when contract_amopere is 50A' do
        let(:contract_ampere) { 50 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 8612
        end
      end
      context 'when contract_amopere is 60A' do
        let(:contract_ampere) { 60 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 8898
        end
      end
    end
  end

  describe 'looop denki' do
    let(:provider_name) { 'Looopでんき' }
    context 'when electric_energy_per_month is 100kWh' do
      let(:electric_energy_per_month) { 100 }
      context 'when contract_amopere is 10A' do
        let(:contract_ampere) { 10 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 2640
        end
      end
    end
    context 'when electric_energy_per_month is 200kWh' do
      let(:electric_energy_per_month) { 200 }
      context 'when contract_amopere is 20A' do
        let(:contract_ampere) { 20 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 5280
        end
      end
    end
    context 'when electric_energy_per_month is 300kWh' do
      let(:electric_energy_per_month) { 300 }
      context 'when contract_amopere is 30A' do
        let(:contract_ampere) { 30 }
        it 'returns valid value' do
          expect(simulator.simulate.filter { |e| e[:provider_name] == provider_name }.first[:price]).to eq 7920
        end
      end
    end
  end
end
