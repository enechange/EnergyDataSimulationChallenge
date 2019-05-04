require 'rails_helper'

RSpec.describe EnergyDatum, type: :model do

  describe 'validation' do
    before do
      @energy_data = FactoryBot.build(:energy_datum)
    end

    it 'is valid with a label house_id year month temperature daylight energy_production' do
      expect(@energy_data).to be_valid
    end

    it 'is invalid without label' do
      energy_data = FactoryBot.build(:energy_datum, label: '')
      energy_data.valid?
      expect(energy_data.errors[:label]).to include("can't be blank")
    end

    it 'is invalid without house_id' do
      energy_data = FactoryBot.build(:energy_datum, house_id: '')
      energy_data.valid?
      expect(energy_data.errors[:house_id]).to include("can't be blank")
    end

    it 'is invalid without year' do
      energy_data = FactoryBot.build(:energy_datum, year: '')
      energy_data.valid?
      expect(energy_data.errors[:year]).to include("can't be blank")
    end

    it 'is invalid without month' do
      energy_data = FactoryBot.build(:energy_datum, month: '')
      energy_data.valid?
      expect(energy_data.errors[:month]).to include("can't be blank")
    end

    it 'is invalid without temperature' do
      energy_data = FactoryBot.build(:energy_datum, temperature: '')
      energy_data.valid?
      expect(energy_data.errors[:temperature]).to include("can't be blank")
    end

    it 'is invalid without daylight' do
      energy_data = FactoryBot.build(:energy_datum, daylight: '')
      energy_data.valid?
      expect(energy_data.errors[:daylight]).to include("can't be blank")
    end

    it 'is invalid without energy_production' do
      energy_data = FactoryBot.build(:energy_datum, energy_production: '')
      energy_data.valid?
      expect(energy_data.errors[:energy_production]).to include("can't be blank")
    end
  end
end
