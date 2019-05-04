require 'rails_helper'

RSpec.describe House, type: :model do

  describe 'validation' do
    before do
      @house = FactoryBot.build(:house)
    end

    it 'is valid with a first_name last_name city num_of_people has_child' do
      expect(@house).to be_valid
    end

    it 'is invalid without a first_name' do
      house = FactoryBot.build(:house, first_name: '')
      house.valid?
      expect(house.errors[:first_name]).to include("can't be blank")
    end

    it 'is invalid without a last_name' do
      house = FactoryBot.build(:house, last_name: '')
      house.valid?
      expect(house.errors[:last_name]).to include("can't be blank")
    end

    it 'is invalid without a city' do
      house = FactoryBot.build(:house, city: '')
      house.valid?
      expect(house.errors[:city]).to include("can't be blank")
    end

    it 'is invalid without a num_of_people' do
      house = FactoryBot.build(:house, num_of_people: '')
      house.valid?
      expect(house.errors[:num_of_people]).to include("can't be blank")
    end

    it 'is invalid without a has_child' do
      house = FactoryBot.build(:house, has_child: '')
      house.valid?
      expect(house.errors[:has_child]).to include('is not included in the list')
    end
  end
end
