require 'rails_helper'

RSpec.describe 'EnergyDataset', type: :model do
  let!(:energy_dataset_1) { create(:energy_dataset_1) }
  let!(:energy_dataset_2) { create(:energy_dataset_2) }

  describe 'validation' do
    it 'presence:trueの値があれば有効であること' do
      expect(energy_dataset_1).to be_valid
    end

    it 'presence:trueの値がなければ無効であること' do
      energy_dataset_1.year = nil
      expect(energy_dataset_1.valid?).to eq false
    end
  end

  describe 'scope' do
    it 'average_energy' do
      expect(EnergyDataset.average_energy).to include [2020,1]=>750
    end

    it 'energy_in_house' do
      expect(EnergyDataset.energy_in_house(energy_dataset_1.house_id)).to include [2020,1]=>700
    end
  end
end
