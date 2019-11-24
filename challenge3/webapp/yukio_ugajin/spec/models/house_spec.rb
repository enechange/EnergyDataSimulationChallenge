require 'rails_helper'

RSpec.describe House, type: :model do
  describe 'create' do
    it '保存できる' do
      expect(build(:house)).to be_valid
    end

    it 'firstnameなしでは保存できない' do
      house = build(:house, firstname: nil)
      house.valid?
      expect(house.errors[:firstname]).to include("can't be blank")
    end

    it 'lastnameなしでは保存できない' do
      house = build(:house, lastname: nil)
      house.valid?
      expect(house.errors[:lastname]).to include("can't be blank")
    end

    it 'cityなしでは保存できない' do
      house = build(:house, city: nil)
      house.valid?
      expect(house.errors[:city]).to include("can't be blank")
    end

    it 'num_of_peopleなしでは保存できない' do
      house = build(:house, num_of_people: nil)
      house.valid?
      expect(house.errors[:num_of_people]).to include("can't be blank")
    end

    it 'cityは数字出ないと保存できない' do
      house = build(:house, city: 'cambridge')
      house.valid?
      expect(house.errors[:city]).to include('is not a number')
    end

    it 'num_of_peopleは数字出ないと保存できない' do
      house = build(:house, num_of_people: 'これは文字です')
      house.valid?
      expect(house.errors[:num_of_people]).to include('is not a number')
    end
  end
end