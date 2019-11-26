require 'rails_helper'

RSpec.describe EnergyDetail, type: :model do
  let(:house) { create(:house) }

  describe 'create' do
    it '保存できる' do
      expect(build(:energy_detail)).to be_valid
    end

    it 'labelなしでは保存できない' do
      energy = build(:energy_detail, label: nil)
      energy.valid?
      expect(energy.errors[:label]).to include("can't be blank")
    end

    it 'labelは整数でないと保存できない' do
      energy = build(:energy_detail, label: 2.1)
      energy.valid?
      expect(energy.errors[:label]).to include('must be an integer')
    end

    it 'yearなしでは保存できない' do
      energy = build(:energy_detail, year: nil)
      energy.valid?
      expect(energy.errors[:year]).to include("can't be blank")
    end

    it 'yearは整数でないと保存できない' do
      energy = build(:energy_detail, year: 2.001)
      energy.valid?
      expect(energy.errors[:year]).to include('must be an integer')
    end

    it 'monthなしでは保存できない' do
      energy = build(:energy_detail, month: nil)
      energy.valid?
      expect(energy.errors[:month]).to include("can't be blank")
    end

    it 'monthは整数でないと保存できない' do
      energy = build(:energy_detail, month: 2.1)
      energy.valid?
      expect(energy.errors[:month]).to include('must be an integer')
    end

    it 'temperatureなしでは保存できない' do
      energy = build(:energy_detail, temperature: nil)
      energy.valid?
      expect(energy.errors[:temperature]).to include("can't be blank")
    end

    it 'temperatureは数字でないと保存できない' do
      energy = build(:energy_detail, temperature: 'ああ')
      energy.valid?
      expect(energy.errors[:temperature]).to include('is not a number')
    end

    it 'daylightなしでは保存できない' do
      energy = build(:energy_detail, daylight: nil)
      energy.valid?
      expect(energy.errors[:daylight]).to include("can't be blank")
    end

    it 'daylightは数字でないと保存できない' do
      energy = build(:energy_detail, daylight: 'ああ')
      energy.valid?
      expect(energy.errors[:daylight]).to include('is not a number')
    end

    it 'energy_productionなしでは保存できない' do
      energy = build(:energy_detail, energy_production: nil)
      energy.valid?
      expect(energy.errors[:energy_production]).to include("can't be blank")
    end

    it 'energy_productionは整数でないと保存できない' do
      energy = build(:energy_detail, energy_production: 2.1)
      energy.valid?
      expect(energy.errors[:energy_production]).to include('must be an integer')
    end

    it 'house_idなしでは保存できない' do
      energy = build(:energy_detail, house: nil)
      energy.valid?
      expect(energy.errors[:house]).to include('must exist')
    end


  end
end
