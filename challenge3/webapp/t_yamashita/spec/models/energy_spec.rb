require 'rails_helper'

describe Energy do
  describe '#create' do
    it "ユーザーidが無いと登録できない" do
      energy = build(:energy, user_id: "")
      energy.valid?
      expect(energy.errors[:user_id]).to include("を入力してください")
    end

    it "年情報が無いと登録できない" do
      energy = build(:energy, year: "")
      energy.valid?
      expect(energy.errors[:year]).to include("を入力してください")     
    end

    it "月情報が無いと登録できない" do
      energy = build(:energy, month: "")
      energy.valid?
      expect(energy.errors[:month]).to include("を入力してください")      
    end

    it "気温情報が無いと登録できない" do
      energy = build(:energy, temperature: "")
      energy.valid?
      expect(energy.errors[:temperature]).to include("を入力してください")        
    end

    it "日照時間情報が無いと登録できない" do
      energy = build(:energy, daylight: "")
      energy.valid?
      expect(energy.errors[:daylight]).to include("を入力してください")      
    end

    it "発電量情報が無いと登録できない" do
      energy = build(:energy, energy_production: "")
      energy.valid?
      expect(energy.errors[:energy_production]).to include("を入力してください")
    end

    it "情報が抜け漏れなければ登録できる" do
      energy = build(:energy)
      expect(energy).to be_valid      
    end
  end
end
