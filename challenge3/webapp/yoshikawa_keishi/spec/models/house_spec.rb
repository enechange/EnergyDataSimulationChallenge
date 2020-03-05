require 'rails_helper'
describe House do
  describe '#create' do
    it "can be saved with all columns filled" do
      house = build(:house)
      expect(house).to be_valid
    end

    it "can't be saved without csv_id" do
      house = build(:house, csv_id: nil)
      house.valid?
      expect(house.errors[:csv_id]).to include("can't be blank")
    end

    it "can't be saved without firstname" do
      house = build(:house, firstname: nil)
      house.valid?
      expect(house.errors[:firstname]).to include("can't be blank")
    end

    it "can't be saved without lastname" do
      house = build(:house, lastname: nil)
      house.valid?
      expect(house.errors[:lastname]).to include("can't be blank")
    end

    it "can't be saved without city" do
      house = build(:house, city: nil)
      house.valid?
      expect(house.errors[:city]).to include("can't be blank")
    end

    it "can't be saved without num_of_people" do
      house = build(:house, num_of_people: nil)
      house.valid?
      expect(house.errors[:num_of_people]).to include("can't be blank")
    end

    it "can't be saved without has_child" do
      house = build(:house, has_child: nil)
      house.valid?
      expect(house.errors[:has_child]).to include("value should be only Yes(yes) or No(no)")
    end

    it "can't be saved with wrong type of has_child input" do
      house = build(:house, has_child: 1)
      house.valid?
      expect(house.errors[:has_child]).to include("value should be only Yes(yes) or No(no)")
    end
  end
end