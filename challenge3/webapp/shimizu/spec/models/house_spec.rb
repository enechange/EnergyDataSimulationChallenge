require 'rails_helper'

RSpec.describe 'House', type: :model do
  describe 'validation' do
    let(:house) { create(:house_1) }

    it 'presence:trueの値があれば有効であること' do
      expect(house).to be_valid
    end

    it 'presence:trueの値がなければ無効であること' do
      house.first_name = nil
      expect(house.valid?).to eq false
    end
  end
end
