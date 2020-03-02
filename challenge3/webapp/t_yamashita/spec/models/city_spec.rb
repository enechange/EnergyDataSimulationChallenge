require 'rails_helper'

describe City do
  describe "#create" do
    it "地名が無いと登録できない" do
      city = build(:city, name: "")
      city.valid?
      expect(city.errors[:name]).to include("を入力してください")
    end

    it "地名があれば登録できる" do
      city = build(:city)
      expect(city).to be_valid
    end
  end
end
