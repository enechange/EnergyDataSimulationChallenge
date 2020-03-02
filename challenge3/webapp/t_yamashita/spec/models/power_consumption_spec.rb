require 'rails_helper'

describe PowerConsumption do
  describe '#create' do
    it "ユーザーidが無いと登録できない" do
      power = build(:power_consumption, user_id: "")
      power.valid?
      expect(power.errors[:user_id]).to include("を入力してください")
    end

    it "年情報が無いと登録できない" do
      power = build(:power_consumption, year: "")
      power.valid?
      expect(power.errors[:year]).to include("を入力してください")     
    end

    it "月情報が無いと登録できない" do
      power = build(:power_consumption, month: "")
      power.valid?
      expect(power.errors[:month]).to include("を入力してください")      
    end

    it "消費電力電量情報が無いと登録できない" do
      power = build(:power_consumption, power_consumption: "")
      power.valid?
      expect(power.errors[:power_consumption]).to include("を入力してください")
    end

    it "情報が抜け漏れなければ登録できる" do
      power = build(:power_consumption)
      expect(power).to be_valid
    end
  end
end
