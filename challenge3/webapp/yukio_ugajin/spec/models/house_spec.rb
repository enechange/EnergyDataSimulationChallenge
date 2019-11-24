require 'rails_helper'

RSpec.describe House, type: :model do
  describe 'create' do
    it '保存できる' do
      expect(build(:house)).to be_valid
    end
  end
end