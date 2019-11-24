require 'rails_helper'

RSpec.describe EnergyDetail, type: :model do
  let(:house) { create(:house) }

  describe 'create' do
    it '保存できる' do
      expect(build(:energy_detail, house_id: house.id)).to be_valid
    end
  end
end
